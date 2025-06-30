# frozen_string_literal: true

class FeedbackQuestionResponse < ApplicationRecord
  belongs_to :feedback_question
  has_one :workshop, through: :feedback_question
end
