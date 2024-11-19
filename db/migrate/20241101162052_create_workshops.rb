class CreateWorkshops < ActiveRecord::Migration[7.1]
  def change
    create_table :workshops do |t|
      t.string :title
      t.string :description
      t.integer :attendance_modality
      t.integer :presentation_modality
      t.integer :registration_modality
      t.integer :virtual_attendance_count, default: 0
      t.integer :in_person_attendance_count, default: 0
      t.string :virtual_location
      t.string :in_person_location
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :finalized, default: true # for development, switch to false for prod

      t.timestamps
    end
  end
end
