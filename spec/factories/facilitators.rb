# frozen_string_literal: true

FactoryBot.define do
  factory :facilitator do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    profile_url { Faker::Internet.url }
    is_admin { false }
    name { Faker::Name.name }

    factory :admin do
      is_admin { true }
    end
  end
end
