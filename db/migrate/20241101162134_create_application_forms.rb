# frozen_string_literal: true

class CreateApplicationForms < ActiveRecord::Migration[7.1]
  def change
    create_table :application_forms do |t|
      t.references :workshop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
