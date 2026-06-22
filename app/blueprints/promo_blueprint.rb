# frozen_string_literal: true

class PromoBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :details, :active

  field :created_at do |obj|
    obj.created_at.iso8601
  end

  field :updated_at do |obj|
    obj.updated_at.iso8601
  end
end
