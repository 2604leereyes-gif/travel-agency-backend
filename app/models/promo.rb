# frozen_string_literal: true

class Promo < ApplicationRecord
  include SoftDeletable

  validates :title, presence: true
  validates :details, presence: true
  validates :active, inclusion: { in: [true, false] }
end
