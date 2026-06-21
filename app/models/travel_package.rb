# frozen_string_literal: true

class TravelPackage < ApplicationRecord
  include SoftDeletable

  mount_uploader :image, ImageUploader

  validates :image, presence: true
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

  default_scope { where(deleted_at: nil) }

  has_many :inquiries, dependent: :destroy

  require 'base64'

  def image_data=(data)
    return if data.blank?
    
    content_type = data.match(/data:(.*);base64/)[1]
    extension = content_type.split('/').last
    decoded = Base64.decode64(data.split(',').last)
    
    temp_file = Tempfile.new(['package_image', ".#{extension}"])
    temp_file.binmode
    temp_file.write(decoded)
    temp_file.rewind
    
    self.image = ActionDispatch::Http::UploadedFile.new(
      tempfile: temp_file,
      filename: "package_image.#{extension}",
      type: content_type
    )
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