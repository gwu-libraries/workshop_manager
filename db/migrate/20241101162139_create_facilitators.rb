# frozen_string_literal: true

class CreateFacilitators < ActiveRecord::Migration[7.1]
  def change
    create_table :facilitators do |t|
      t.string :name
      t.boolean :is_admin
      t.string :profile_url

      t.timestamps
    end
  end
end
