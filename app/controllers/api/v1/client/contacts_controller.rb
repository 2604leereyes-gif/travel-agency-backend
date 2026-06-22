# frozen_string_literal: true

class Api::V1::Client::ContactsController < Api::V1::ClientController
  def show
    contact = Contact.first

    if contact
      render json: ContactBlueprint.render_as_hash(contact)
    else
      render json: { error: "Contact not found" }, status: :not_found
    end
  end
end
