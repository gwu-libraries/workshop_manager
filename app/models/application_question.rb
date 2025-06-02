# frozen_string_literal: true

class ApplicationQuestion < ApplicationRecord
  enum :question_format,
       { true_false: 0, likert: 1, short_answer: 2, long_answer: 3 }

  belongs_to :workshop

  has_many :application_question_responses
end
