# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :email, :role, :created_at

  # optional formatting
  field :created_at do |user|
    user.created_at.iso8601
  end
end