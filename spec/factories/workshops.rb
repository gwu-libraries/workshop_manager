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
    virtual_location { 'A Zoom Room' }

    in_person_location { "Room #{rand(100..1000)}" }

    attendance_modality { [0, 1].sample }

    presentation_modality { [0, 1, 2].sample }

    registration_modality { [0, 1, 2].sample }

    proposal_status { 'approved' }

    factory :past_application_workshop do
      registration_modality { 'application_required' }
      start_time { DateTime.now - rand(14).days - rand(4).hours }
      end_time { start_time + 2.hours }
    end

    factory :past_registration_workshop do
      registration_modality { 'registration_required' }
      start_time { DateTime.now - rand(14).days - rand(4).hours }
      end_time { start_time + 2.hours }
    end

    factory :past_open_workshop do
      registration_modality { 'no_registration_required' }
      start_time { DateTime.now - rand(14).days - rand(4).hours }
      end_time { start_time + 2.hours }
    end

    factory :future_application_workshop do
      registration_modality { 'application_required' }
      attendance_modality { [0, 1].sample }
      start_time { DateTime.now + rand(14).days - rand(4).hours }
      end_time { start_time + 2.hours }
    end

    factory :future_registration_workshop do
      registration_modality { 'registration_required' }
      attendance_modality { [0, 1].sample }
      start_time { DateTime.now + rand(14).days - rand(4).hours }
      end_time { start_time + 2.hours }
    end

    factory :future_open_workshop do
      registration_modality { 'no_registration_required' }
      attendance_modality { [0, 1].sample }
      start_time { DateTime.now + rand(14).days - rand(4).hours }
      end_time { start_time + 2.hours }
    end

    factory :proposal_pending_workshop do
      proposal_status { 'pending' }
      # these should always be in the future
      start_time { DateTime.now + rand(14).days - rand(4).hours }
      end_time { start_time + 2.hours }
    end

    factory :rejected_workshop do
      proposal_status { 'rejected' }
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
