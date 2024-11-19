class CreateApplicationTemplates < ActiveRecord::Migration[7.1]
  def change
    create_table :application_templates do |t|
      t.timestamps
    end
  end
end
