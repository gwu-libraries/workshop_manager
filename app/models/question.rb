class Question < ApplicationRecord
  enum :question_format,
       { true_false: 0, likert: 1, short_answer: 2, long_answer: 3 }

  has_many :application_template_questions
  has_many :application_templates, through: :application_template_questions
end
