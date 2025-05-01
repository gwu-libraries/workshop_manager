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

    proposal_status { [0, 1].sample }

    factory :pending_track do
      proposal_status { 'pending' }
    end

    factory :approved_track do
      proposal_status { 'approved' }
    end

    factory :rejected_track do
      proposal_status { 'rejected' }
    end
  end
end
