class CreateFacilitators < ActiveRecord::Migration[7.1]
  def change
    create_table :facilitators do |t|
      t.string :name

      t.timestamps
    end
  end
end
