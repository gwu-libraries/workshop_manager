FactoryBot.define do
  factory :facilitator do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.name }
    is_admin { false }

    factory :admin do
      is_admin { true }
    end
  end
end
