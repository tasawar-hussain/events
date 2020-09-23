# frozen_string_literal: true

class GroupEvent < ApplicationRecord
  acts_as_paranoid double_tap_destroys_fully: false

  validates :name, presence: true, if: :published?
  validates :name, uniqueness: true, length: { maximum: 200 }
  validates :description, presence: true, if: :published?
  validates :location, presence: true, if: :published?
  validates :duration, presence: true, if: :published?
  validates :start_date, presence: true, if: :published?
  validates :end_date, presence: true, if: :published?
  validates :duration, numericality: { greater_than: 0, only_integer: true }, if: -> { duration.present? }
end
