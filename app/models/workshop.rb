class Workshop < ApplicationRecord
  enum :attendance_modality, { individual: 0, collective: 1 }
  enum :presentation_modality, { in_person: 0, virtual: 1, hybrid: 2 }
  enum :registration_modality,
       {
         no_registration_required: 0,
         registration_required: 1,
         application_required: 2
       }

  has_many :track_workshops, dependent: :destroy
  has_many :tracks, through: :track_workshops

  has_many :workshop_facilitators, dependent: :destroy
  has_many :facilitators, through: :workshop_facilitators

  has_many :workshop_participants, dependent: :destroy
  has_many :participants, through: :workshop_participants

  has_many :workshop_application_templates
  has_many :application_templates, through: :workshop_application_templates

  def total_attendance
    if self.attendance_modality == 'individual'
      self.workshop_participants.where(in_attendance: true).count
    elsif self.attendance_modality == 'collective'
      self.in_person_attendance_count + self.virtual_attendance_count
    end
  end
end
