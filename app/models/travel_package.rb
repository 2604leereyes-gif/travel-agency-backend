# frozen_string_literal: true

class TravelPackage < ApplicationRecord
  include SoftDeletable

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

  default_scope { where(deleted_at: nil) }

  has_many :inquiries, dependent: :destroy

  def set_defaults
    self.is_active = true if is_active.nil?
    self.destination ||= travel_package.destination
    self.number_of_travelers ||= travel_package.number_of_travelers
    self.estimated_budget ||= travel_package.base_price
  end

  def active?
    is_active
  end

  def soft_delete
    update(deleted_at: Time.current)
  end

  def restore
    update(deleted_at: nil)
  end


  def deleted?
    deleted_at.present?
  end


  def self.view_deleted
    unscoped.where.not(deleted_at: nil)
  end


  def self.view_all
    unscoped
  end
end