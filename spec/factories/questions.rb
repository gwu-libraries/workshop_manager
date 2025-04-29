# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    prompt { "What's your favorite kind of " }
    question_format { [0, 1, 2, 3].sample }

    factory :true_false_question do
      prompt { "Do you like #{Faker::Food.vegetables}?" }
      question_format { 'true_false' }
    end

    factory :short_answer_question do
      prompt { "How do you feel about #{Faker::Food.vegetables}?" }
      question_format { 'short_answer' }
    end

    factory :long_answer_question do
      prompt { "How do you really feel about #{Faker::Food.vegetables}?" }
      question_format { 'long_answer' }
    end

    factory :likert_question do
      prompt do
        "Scale of 1 to 5, how do you feel about #{Faker::Food.vegetables}?"
      end
      question_format { 'likert' }
    end
  end
end
