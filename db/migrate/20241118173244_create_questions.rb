# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :prompt
      t.integer :question_format

      t.timestamps
    end
  end
end
