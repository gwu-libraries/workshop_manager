# frozen_string_literal: true

class CreateApplicationQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :application_questions do |t|
      t.references :workshop, null: false, foreign_key: true
      t.string :prompt
      t.integer :question_format

      t.timestamps
    end
  end
end
