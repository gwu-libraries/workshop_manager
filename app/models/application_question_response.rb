# frozen_string_literal: true

class ApplicationQuestionResponse < ApplicationRecord
  belongs_to :application_question
  belongs_to :participant
end
