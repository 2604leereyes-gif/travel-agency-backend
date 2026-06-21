# frozen_string_literal: true

class Subscriber < ApplicationRecord
  enum status: { active: 0, unsubscribed: 1 }

  validates :email, presence: true, uniqueness: true
  validates :status, presence: true

  before_create :generate_unsubscribe_token
  before_create :set_subscribed_at

  private

  def generate_unsubscribe_token
    self.unsubscribe_token = SecureRandom.urlsafe_base64
  end

  def set_subscribed_at
    self.subscribed_at = Time.current
  end
end
