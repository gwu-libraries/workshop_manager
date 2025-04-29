# frozen_string_literal: true

class AddUuidToWorkshops < ActiveRecord::Migration[8.0]
  def change
    add_column :workshops,
               :uuid,
               :uuid,
               default: 'gen_random_uuid()',
               null: false
  end
end
