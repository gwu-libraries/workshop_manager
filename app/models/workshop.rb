class Workshop < ApplicationRecord
  enum :attendance_modality, { individual: 0, collective: 1 }
  enum :presentation_modality, { in_person: 0, virtual: 1, hybrid: 2 }
  enum :registration_modality,
       {
         no_registration_required: 0,
         registration_required: 1,
         application_required: 2
       }
  enum :proposal_status, { pending: 0, approved: 1, rejected: 2 }

  has_many :track_workshops, dependent: :destroy
  has_many :tracks, through: :track_workshops

  has_many :workshop_facilitators, dependent: :destroy
  has_many :facilitators, through: :workshop_facilitators

  has_many :workshop_participants, dependent: :destroy
  has_many :participants, through: :workshop_participants

  has_many :workshop_application_templates
  has_many :application_templates, through: :workshop_application_templates

  has_many_attached :attachments

  scope :pending, -> { where(proposal_status: 'pending') }
  scope :approved, -> { where(proposal_status: 'approved') }
  scope :upcoming, -> { where('start_time > ?', DateTime.now) }
  scope :past, -> { where('end_time < ?', DateTime.now) }

  after_update :send_timing_update_notification,
               if: ->(workshop) do
                 workshop.saved_change_to_start_time? ||
                   workshop.saved_change_to_end_time?
               end
  after_update :send_location_update_notification,
               if: ->(workshop) do
                 workshop.saved_change_to_in_person_location? ||
                   workshop.saved_change_to_virtual_location?
               end

  def total_attendance
    case self.attendance_modality
    when 'individual'
      self.workshop_participants.where(in_attendance: true).count
    when 'collective'
      self.in_person_attendance_count + self.virtual_attendance_count
    end
  end

  private

  def send_timing_update_notification
    self.participants.each do |participant|
      WorkshopTimingUpdateEmailJob.perform_async(
        { workshop_id: self.id, participant_id: participant.id }.stringify_keys
      )
    end
  end

  def send_location_update_notification
    self.participants.each do |participant|
      WorkshopLocationUpdateEmailJob.perform_async(
        { workshop_id: self.id, participant_id: participant.id }.stringify_keys
      )
    end
  end
end
