# frozen_string_literal: true

class CreateFeedbackFormResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :feedback_form_responses do |t|
      t.references :feedback_form, null: false, foreign_key: true
      t.jsonb :response_data, null: true

      t.timestamps
    end
  end
end
