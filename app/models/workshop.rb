class Workshop < ApplicationRecord
  enum :attendance_strategy, { individual: 0, collective: 1 }

  has_many :track_workshops
  has_many :tracks, through: :track_workshops

  has_many :workshop_facilitators
  has_many :facilitators, through: :workshop_facilitators

  has_many :workshop_participants
  has_many :participants, through: :workshop_participants
end
