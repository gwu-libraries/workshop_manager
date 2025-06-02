# frozen_string_literal: true

class CreateParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :participants do |t|
      t.references :workshop, null: false, foreign_key: true
      t.string :name
      t.string :email
      t.boolean :in_attendance, null: true
      t.integer :application_status

      t.timestamps
    end
  end
end
