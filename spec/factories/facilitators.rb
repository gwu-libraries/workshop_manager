FactoryBot.define do
  factory :facilitator do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.name }
  end
end
