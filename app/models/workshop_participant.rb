class WorkshopParticipant < ApplicationRecord
  belongs_to :workshop
  belongs_to :participant
end
