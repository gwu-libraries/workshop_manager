FactoryBot.define do
  factory :workshop do
    title do
      "How to #{Faker::Verb.base} your #{Faker::Creature::Animal.name}".titleize
    end
    description do
      Faker::Lorem.paragraph(
        sentence_count: 12,
        supplemental: true,
        random_sentences_to_add: 4
      )
    end

    attendance_modality { [0, 1].sample }

    presentation_modality { [0, 1, 2].sample }

    registration_modality { [0, 1, 2].sample }

    virtual_location { 'A Zoom Room' }

    in_person_location { "Room #{rand(100..1000)}" }

    proposal_status { 'approved' }

    factory :proposal_pending_workshop do
      proposal_status { 'pending' }
    end

    factory :rejected_workshop do
      proposal_status { 'rejected' }
    end

    factory :current_workshop do
      start_time { DateTime.now - 1.hours }
      end_time { DateTime.now + 1.hours }
    end

    factory :past_workshop do
      start_time { DateTime.now - rand(14).days - rand(4).hours }
      end_time { start_time + 2.hours }
    end

    factory :future_workshop do
      start_time { DateTime.now + rand(14).days - rand(4).hours }
      end_time { start_time + 2.hours }
    end
  end
end
