FactoryBot.define do
  factory :track do
    sequence(:title) { |n| "Workshop Track #{n}" }

    description do
      Faker::Lorem.paragraph(
        sentence_count: 12,
        supplemental: true,
        random_sentences_to_add: 4
      )
    end
  end
end
