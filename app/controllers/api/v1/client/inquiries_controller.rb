# frozen_string_literal: true

class Api::V1::InquiriesController < Api::V1::ClientController
  def create
    inquiry = Inquiry.new(inquiry_params)

    if inquiry.save
      render json: InquiryBlueprint.render_as_hash(inquiry), status: :created
    else
      render json: { errors: inquiry.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(
      :email,
      :full_name,
      :phone_number,
      :destination,
      :departure_date,
      :return_date,
      :number_of_travelers,
      :estimated_budget,
      :notes,
      :travel_package_id
    )
  end
end
