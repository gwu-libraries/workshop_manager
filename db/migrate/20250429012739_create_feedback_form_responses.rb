# frozen_string_literal: true

class CreateFeedbackFormResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :feedback_form_responses do |t|
      t.references :workshop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
