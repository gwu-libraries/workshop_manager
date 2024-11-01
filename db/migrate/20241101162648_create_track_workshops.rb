class CreateTrackWorkshops < ActiveRecord::Migration[7.1]
  def change
    create_table :track_workshops do |t|
      t.references :track, null: false, foreign_key: true
      t.references :workshop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
