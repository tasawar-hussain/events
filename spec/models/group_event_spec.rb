# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupEvent, type: :model do
  # Here we're using FactoryBot, but you could use anything
  subject { build(:group_event, :published) }

  describe 'basic validations' do
    it { is_expected.to validate_numericality_of(:duration) }
    it { is_expected.to validate_length_of(:nmae) }
    it { is_expected.to validate_length_of(:location) }

    it "can't updated published event" do
      subject.valid?
      subject.save!
      subject.name = 'new name'
      expect(subject.valid?).to eq(false)
      expect(subject.errors[:base]).to include('Cant update event after it has been published')
      expect { subject.save! }.to raise_exception(ActiveRecord::RecordInvalid)
    end

    it 'should not save two events with same name' do
      subject.save!
      new_subject = build(:group_event, :published)
      new_subject.name = subject.name
      expect(new_subject.valid?).to eq(false)

      expect(new_subject.errors[:name]).to include('has already been taken')
      expect { new_subject.save! }.to raise_exception(ActiveRecord::RecordInvalid)
    end
  end

  describe 'start date , end date and duration validations' do
    it 'start date can not be after end date' do
      subject.start_date = subject.end_date + 2.days
      expect(subject.valid?).to eq(false)
      expect(subject.errors[:start_date]).to include('should be before the end date')
      expect { subject.save!}.to raise_exception(ActiveRecord::RecordInvalid)
    end

    it 'end date can not be in past' do
      subject.end_date = Date.today - 2.days
      expect(subject.valid?).to eq(false)
      expect(subject.errors[:end_date]).to include('can not be in past')
      expect { subject.save!}.to raise_exception(ActiveRecord::RecordInvalid)
    end

    it 'duration must be equal to difference of start and end date' do
      subject.end_date = subject.start_date + 10
      subject.duration = 15
      expect(subject.valid?).to eq(false)
      expect(subject.errors[:duration]).to include('must be equal to differnce between start and end date')
      expect { subject.save! }.to raise_exception(ActiveRecord::RecordInvalid)
    end
  end

  describe 'validate atleast 2 fields are required' do
    it 'should not save if start date and end date are missing' do
      subject.duration = 10
      subject.start_date = nil
      subject.end_date = nil
      expect(subject.valid?).to eq(false)
      expect(subject.errors[:start_date]).to include("can't be blank")
      expect(subject.errors[:end_date]).to include("can't be blank")
    end

    it 'should not save if start date and duration are missing' do
      subject.end_date = Time.zone.today
      subject.duration = nil
      subject.start_date = nil
      expect(subject.valid?).to eq(false)
      expect(subject.errors[:start_date]).to include("can't be blank")
      expect(subject.errors[:duration]).to include("can't be blank")
    end

    it 'should not save if duration and end date are missing' do
      subject.start_date = Time.zone.today
      subject.end_date = nil
      subject.duration = nil
      expect(subject.valid?).to eq(false)
      expect(subject.errors[:end_date]).to include("can't be blank")
      expect(subject.errors[:duration]).to include("can't be blank")
    end
  end

  describe 'valid event state (published/draft)' do
    it 'should create a published event' do
      expect(subject.valid?).to eq(true)
      subject.save
      expect(subject.published).to eq(true)
    end

    it 'should create a draft for subset of fields' do
      subject.published = false
      subject.name = nil
      expect(subject.valid?).to eq(true)
      subject.save
      expect(subject.published).to eq(false)
    end
  end

  describe 'validate all fields are mandatory for being published' do
    required_columns = %i[name description location]

    required_columns.each do |attribute|
      it "should not save if #{attribute} is missing" do
        group_event = build(:group_event, :published)
        group_event[attribute] = nil
        expect(group_event.valid?).to eq(false)
        group_event.destroy_fully!
      end
    end
  end

  describe 'it should calculate correct missing field' do
    it 'create a published event with correct duration' do
      subject.duration = nil
      expect(subject.valid?).to eq(true)
      subject.save
      duration = (subject.end_date - subject.start_date).to_i + 1
      expect(subject.duration).to eq(duration)
    end

    it 'create a published event with correct end date' do
      subject.end_date = nil
      duration = 3
      subject.duration = duration
      expect(subject.valid?).to eq(true)
      subject.save
      end_date = subject.start_date + duration.day - 1
      expect(subject.end_date).to eq(end_date)
    end

    it 'create a published event with correct start date' do
      subject.start_date = nil
      duration = 3
      subject.duration = duration
      expect(subject.valid?).to eq(true)
      subject.save
      start_date = subject.end_date - duration.day - 1
      expect(subject.start_date).to eq(start_date)
    end
  end
end
