class ApplicationTemplateQuestion < ApplicationRecord
  belongs_to :application_template
  belongs_to :question
end
