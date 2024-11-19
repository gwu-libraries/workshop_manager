FactoryBot.define do
  factory :question do
    sequence(:prompt) { |n| "Ey I'm a prompt for question number #{n}" }
    question_format { [0, 1, 2, 3].sample }
  end
end
