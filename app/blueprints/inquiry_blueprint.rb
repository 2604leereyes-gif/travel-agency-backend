# frozen_string_literal: true

class InquiryBlueprint < Blueprinter::Base
  identifier :id

  fields :email, :full_name, :phone_number, :destination, :departure_date, :return_date, :number_of_travelers, :estimated_budget, :notes, :status, :travel_package_id

  field :created_at do |obj|
    obj.created_at.iso8601
  end

  field :updated_at do |obj|
    obj.updated_at.iso8601
  end
end