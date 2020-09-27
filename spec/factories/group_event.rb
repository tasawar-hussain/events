# frozen_string_literal: true

require 'securerandom'

FactoryBot.define do
  factory :group_event do
    name { Faker::Esport.event + SecureRandom.hex[0..7] } # To solve Faker::UniqueGenerator::RetryLimitExceeded
    description { Faker::Restaurant.description }
    location { Faker::Address.full_address }

    trait :published do
      start_date { Time.zone.today - 5.days }
      end_date { start_date + 10.days }
      published { true }
    end
  end
end
