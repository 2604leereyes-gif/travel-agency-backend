# frozen_string_literal: true

class ContactBlueprint < Blueprinter::Base
  identifier :id

  fields :phone_numbers, :emails, :business_hours, :google_maps_url, :address

  field :created_at do |obj|
    obj.created_at.iso8601
  end

  field :updated_at do |obj|
    obj.updated_at.iso8601
  end
end
