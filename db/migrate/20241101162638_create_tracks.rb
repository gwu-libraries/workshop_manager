# frozen_string_literal: true

class CreateTracks < ActiveRecord::Migration[7.1]
  def change
    create_table :tracks do |t|
      t.string :title
      t.string :description
      t.integer :proposal_status, default: 0

      t.timestamps
    end
  end
end
