# frozen_string_literal: true

class GroupEvent < ApplicationRecord
  acts_as_paranoid double_tap_destroys_fully: false
  validates_as_paranoid

  validates :name, presence: true, if: :published?
  validates_uniqueness_of_without_deleted :name
  validates :name, length: { maximum: 200 }
  validates :location, length: { maximum: 200 }
  validates :description, presence: true, if: :published?
  validates :location, presence: true, if: :published?
  validates :duration, numericality: { greater_than: 0, only_integer: true }, if: -> { duration.present? }

  validates :duration, presence: true, if: :cant_infer_duration?
  validates :start_date, presence: true, if: :cant_infer_start_date?
  validates :end_date, presence: true, if: :cant_infer_end_date?

  validate :validate_duration, :validate_start_date, :validate_end_date
  validate :restrict_updation, on: :update

  before_save :calculate_duration, :calculate_start_date, :calculate_end_date, if: -> { published? }

  def published?
    published == true
  end

  private

  def infer_duration?
    (start_date.blank? || end_date.blank?)
  end

  def cant_infer_duration?
    published? && (start_date.blank? || end_date.blank?)
  end

  def cant_infer_start_date?
    published? && (duration.blank? || end_date.blank?)
  end

  def cant_infer_end_date?
    published? && (start_date.blank? || duration.blank?)
  end

  def restrict_updation
    errors.add(:base, 'Cant update event after it has been published') if published_was
  end

  def validate_end_date
    return if published_was || end_date.blank?

    errors.add(:end_date, 'can not be in past') if end_date < Time.zone.today
  end

  def validate_start_date
    return if check_published_and_start_end_date?

    calculated_duration = calculate_days

    errors.add(:start_date, 'should be before the end date') if calculated_duration < 1
  end

  def validate_duration
    return if check_published_and_start_end_date?

    calculated_duration = calculate_days
    return unless published? && duration && calculated_duration != duration

    errors.add(:duration, 'must be equal to differnce between start and end date')
  end

  def calculate_duration
    self.duration = calculate_days if duration_missing?
  end

  def calculate_start_date
    self.start_date = end_date - duration.days - 1 if start_date_missing?
  end

  def calculate_end_date
    self.end_date = start_date + duration.days - 1 if end_date_missing?
  end

  def duration_missing?
    duration.blank? && start_date.present? && end_date.present?
  end

  def start_date_missing?
    start_date.blank? && end_date.present? && duration.present?
  end

  def end_date_missing?
    end_date.blank? && start_date.present? && duration.present?
  end

  def calculate_days
    # If event starts and ends on same day, it will considered 1 day event
    (end_date - start_date).to_i + 1
  end

  def check_published_and_start_end_date?
    published_was || end_date.blank? || start_date.blank?
  end
end
