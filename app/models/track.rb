class Track < ApplicationRecord
  has_many :track_workshops
  has_many :workshops, through: :track_workshops
end
