class Workshop < ApplicationRecord
  enum :attendance_strategy, { individual: 0, collective: 1 }
  enum :modality, { in_person: 0, virtual: 1, hybrid: 2 }

  has_many :track_workshops, dependent: :destroy
  has_many :tracks, through: :track_workshops

  has_many :workshop_facilitators, dependent: :destroy
  has_many :facilitators, through: :workshop_facilitators

  has_many :workshop_participants, dependent: :destroy
  has_many :participants, through: :workshop_participants

  def total_attendance
    if self.attendance_strategy == 'individual'
      self.workshop_participants.where(in_attendance: true).count
    elsif self.attendance_strategy == 'collective'
      self.in_person_attendance_count + self.virtual_attendance_count
    end
  end
end
