# frozen_string_literal: true

class TravelPackageBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :description, :base_price, :show_price, :number_of_travelers, :destination, :is_active

  field :created_at do |obj|
    obj.created_at.iso8601
  end

  field :updated_at do |obj|
    obj.updated_at.iso8601
  end
end