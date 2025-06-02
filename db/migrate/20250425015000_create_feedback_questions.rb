# frozen_string_literal: true

class CreateFeedbackQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :feedback_questions do |t|
      t.references :workshop, null: false, foreign_key: true
      t.string :prompt
      t.integer :question_format

      t.timestamps
    end
  end
end
