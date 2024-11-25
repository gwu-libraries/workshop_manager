class WorkshopParticipant < ApplicationRecord
  enum :application_status,
       { pending: 0, accepted: 1, rejected: 2, waitlisted: 3 }

  belongs_to :workshop
  belongs_to :participant
end
