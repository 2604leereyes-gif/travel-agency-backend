# frozen_string_literal: true

class Inquiry < ApplicationRecord
  include SoftDeletable

  belongs_to :travel_package, optional: true

  enum status: {
    pending: 0,
    reviewed: 1,
    accepted: 2,
    cancelled: 3
  }


  validates :email, presence: true
  validates :full_name, presence: true

  validates :number_of_travelers,
            numericality: { greater_than: 0, allow_nil: true }

  validates :estimated_budget,
            numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  validate :valid_date_range


  before_validation :apply_travel_package_defaults, if: -> { travel_package.present? }

  def self.statuses_for_select
    statuses.keys.map { |status| [status.humanize, status] }
  end

  private

  def apply_travel_package_defaults
    self.destination ||= travel_package.destination
    self.number_of_travelers ||= travel_package.number_of_travelers
    self.estimated_budget ||= travel_package.base_price
  end

  def valid_date_range
    return if departure_date.blank? || return_date.blank?

    if return_date < departure_date
      errors.add(:return_date, "must be after departure date")
    end
  end
end