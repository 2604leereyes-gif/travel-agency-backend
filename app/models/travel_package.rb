# frozen_string_literal: true

class TravelPackage < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :destination, presence: true
  validates :is_active, presence: true
  validates :number_of_travelers, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :base_price,
            presence: true,
            numericality: { greater_than: 0 }

  scope :active, -> { where(is_active: true) }
  scope :destination, ->(destination) { where(destination: destination) if destination.present? }
 
  after_initialize :set_defaults, if: :new_record?

  def set_defaults
    self.is_active = true if is_active.nil?
  end

  def active?
    is_active
  end
end