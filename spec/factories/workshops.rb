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

    attendance_strategy { [0, 1].sample }

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
