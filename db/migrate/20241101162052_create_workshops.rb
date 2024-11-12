class CreateWorkshops < ActiveRecord::Migration[7.1]
  def change
    create_table :workshops do |t|
      t.string :title
      t.string :description
      t.string :location
      t.integer :attendance_strategy
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
