# frozen_string_literal: true

class Api::V1::Admin::ContactsController < Api::V1::AdminController
  def show
    contact = Contact.first

    if contact
      render json: ContactBlueprint.render_as_hash(contact)
    else
      render json: { error: "Contact not found" }, status: :not_found
    end
  end

  def update
    contact = Contact.first

    if contact.nil?
      render json: { error: "Contact not found" }, status: :not_found
      return
    end
    if contact.update(contact_params)
      render json: ContactBlueprint.render_as_hash(contact)
    else
      render json: { error: contact.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(
        :address,
        :google_maps_url,
        phone_numbers: [:key, :value],
        emails: [:key, :value],
        business_hours: [:key, :value]
    )
  end
end
