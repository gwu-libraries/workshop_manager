# frozen_string_literal: true

class CreateWorkshopParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :workshop_participants do |t|
      t.references :workshop, null: false, foreign_key: true
      t.references :participant, null: false, foreign_key: true
      t.jsonb :application_responses, null: true
      t.boolean :in_attendance, null: true
      t.integer :application_status

      t.timestamps
    end
  end
end
