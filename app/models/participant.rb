class Participant < ApplicationRecord
  has_many :workshop_participants
  has_many :workshops, through: :workshop_participants
end
