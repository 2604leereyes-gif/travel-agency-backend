# frozen_string_literal: true

class SubscriberBlueprint < Blueprinter::Base
  identifier :id

  fields :email, :name, :status, :unsubscribe_token

  field :subscribed_at do |subscriber|
    subscriber.subscribed_at&.iso8601
  end

  field :created_at do |subscriber|
    subscriber.created_at&.iso8601
  end

  field :updated_at do |subscriber|
    subscriber.updated_at&.iso8601
  end
end