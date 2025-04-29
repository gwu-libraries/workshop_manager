# frozen_string_literal: true

class TrackWorkshop < ApplicationRecord
  belongs_to :track
  belongs_to :workshop
end
