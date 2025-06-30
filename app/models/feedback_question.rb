# frozen_string_literal: true

class FeedbackQuestion < ApplicationRecord
  belongs_to :workshop
  has_many :feedback_question_responses

  enum :question_format,
       { true_false: 0, likert: 1, short_answer: 2, long_answer: 3 }
end
