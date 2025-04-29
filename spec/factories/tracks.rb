# frozen_string_literal: true

FactoryBot.define do
  factory :track do
    title { Faker::Science.science }

    description do
      Faker::Lorem.paragraph(
        sentence_count: 12,
        supplemental: true,
        random_sentences_to_add: 4
      )
    end
  end
end
