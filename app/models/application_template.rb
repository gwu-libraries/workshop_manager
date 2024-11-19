class ApplicationTemplate < ApplicationRecord
  has_one :workshop_application
  has_one :workshop, through: :workshop_applications

  has_many :application_template_questions
  has_many :questions, through: :application_template_questions
end
