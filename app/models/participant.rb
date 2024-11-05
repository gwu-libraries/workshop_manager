class Participant < ApplicationRecord
  has_many :workshop_participants
  has_many :workshops, through: :workshop_participants

  def marked_present?(workshop_id)
    WorkshopParticipant.find_by(
      workshop_id: workshop_id,
      participant_id: self.id
    ).in_attendance
  end
end
