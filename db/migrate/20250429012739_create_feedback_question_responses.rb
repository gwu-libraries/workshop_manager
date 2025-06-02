# frozen_string_literal: true

class CreateFeedbackQuestionResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :feedback_question_responses do |t|
      t.references :feedback_question, null: false, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
