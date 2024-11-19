class CreateWorkshopApplicationTemplates < ActiveRecord::Migration[7.1]
  def change
    create_table :workshop_application_templates do |t|
      t.references :workshop, null: false, foreign_key: true
      t.references :application_template, null: false, foreign_key: true

      t.timestamps
    end
  end
end
