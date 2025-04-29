# frozen_string_literal: true

class FeedbackForm < ApplicationRecord
  belongs_to :workshop

  has_many :feedback_form_questions
  has_many :questions, through: :feedback_form_questions
end
