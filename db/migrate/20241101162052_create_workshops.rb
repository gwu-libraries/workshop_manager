class CreateWorkshops < ActiveRecord::Migration[7.1]
  def change
    create_table :workshops do |t|
      t.string :title
      t.string :description
      t.integer :attendance_strategy
      t.integer :virtual_attendance_count
      t.integer :in_person_attendance_count
      t.integer :modality
      t.string :virtual_location
      t.string :in_person_location
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
