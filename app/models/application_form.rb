class ApplicationForm < ApplicationRecord
  belongs_to :workshop

  has_many :application_form_questions
  has_many :questions, through: :application_form_questions
end
