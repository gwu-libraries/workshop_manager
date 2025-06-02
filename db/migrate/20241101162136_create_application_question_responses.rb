# frozen_string_literal: true

class CreateApplicationQuestionResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :application_question_responses do |t|
      t.references :application_question, null: false, foreign_key: true
      t.references :participant, null: false, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
