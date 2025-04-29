# frozen_string_literal: true

class CreateWorkshops < ActiveRecord::Migration[7.1]
  def change
    create_table :workshops do |t|
      t.string :title
      t.string :description
      t.integer :proposal_status, default: 0
      t.integer :attendance_modality
      t.integer :presentation_modality
      t.integer :registration_modality
      t.integer :virtual_attendance_count, default: 0
      t.integer :in_person_attendance_count, default: 0
      t.string :virtual_location
      t.string :in_person_location
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :use_feedback_form, default: false

      t.timestamps
    end
  end
end
