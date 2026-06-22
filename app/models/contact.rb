# frozen_string_literal: true

class Contact < ApplicationRecord
  validates :address, presence: true
  validates :phone_numbers, presence: true
  validate :phone_numbers_format
  validate :emails_format
  validate :business_hours_format
  validate :only_one_contact, on: :create

  private

  def only_one_contact
    errors.add(:base, "Only one contact is allowed") if Contact.first.present?
  end

  def phone_numbers_format
    return if phone_numbers.blank?

    unless phone_numbers.is_a?(Array) && phone_numbers.any?
      errors.add(:phone_numbers, "must be an array with at least one entry")
      return
    end

    phone_numbers.each do |entry|
      unless entry.is_a?(Hash) && entry.key?("value")
        errors.add(:phone_numbers, "each entry must be a hash with a 'value' key")
      end
    end
  end

  def emails_format
    return if emails.blank?

    unless emails.is_a?(Array) && emails.any?
      errors.add(:emails, "must be an array with at least one entry")
      return
    end

    emails.each do |entry|
      unless entry.is_a?(Hash) && entry.key?("value")
        errors.add(:emails, "each entry must be a hash with a 'value' key")
      end
    end
  end

  def business_hours_format
    return if business_hours.blank?

    unless business_hours.is_a?(Array)
      errors.add(:business_hours, "must be an array")
      return
    end

    business_hours.each do |entry|
      unless entry.is_a?(Hash) && entry.key?("value")
        errors.add(:business_hours, "each entry must be a hash with a 'value' key")
      end
    end
  end
end
