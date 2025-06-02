# frozen_string_literal: true

FactoryBot.define do
  factory :participant do
    name { Faker::Name.name }
    sequence(:email) { |n| "participant-#{n}@example.com" }
    application_status { 'accepted' }
    workshop_id {}
  end
end
