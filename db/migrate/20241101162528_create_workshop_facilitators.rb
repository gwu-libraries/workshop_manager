class CreateWorkshopFacilitators < ActiveRecord::Migration[7.1]
  def change
    create_table :workshop_facilitators do |t|
      t.references :workshop, null: false, foreign_key: true
      t.references :facilitator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
