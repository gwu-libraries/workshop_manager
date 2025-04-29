# frozen_string_literal: true

class CreateFeedbackForms < ActiveRecord::Migration[7.1]
  def change
    create_table :feedback_forms do |t|
      t.references :workshop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
