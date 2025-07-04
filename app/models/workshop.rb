# frozen_string_literal: true

class Workshop < ApplicationRecord
  has_many_attached :attachments

  has_many :application_questions
  has_many :application_question_responses, through: :application_questions

  has_many :feedback_questions
  has_many :feedback_question_responses, through: :feedback_questions

  has_many :participants

  has_many :track_workshops, dependent: :destroy
  has_many :tracks, through: :track_workshops

  has_many :workshop_facilitators, dependent: :destroy
  has_many :facilitators, through: :workshop_facilitators

  enum :attendance_modality, { individual: 0, collective: 1 }
  enum :presentation_modality, { in_person: 0, virtual: 1, hybrid: 2 }
  enum :registration_modality,
       {
         no_registration_required: 0,
         registration_required: 1,
         application_required: 2
       }
  enum :proposal_status, { pending: 0, approved: 1, rejected: 2 }

  # approval status scopes
  scope :pending, -> { where(proposal_status: 'pending') }
  scope :approved, -> { where(proposal_status: 'approved') }
  scope :rejected, -> { where(proposal_status: 'rejected') }

  # time scopes
  scope :upcoming, -> { where('start_time > ?', DateTime.now) }
  scope :past, -> { where('end_time < ?', DateTime.now) }

  # application modality scopes
  scope :application_required,
        -> { where(registration_modality: 'application_required') }
  scope :no_registration_required,
        -> { where(registration_modality: 'no_registration_required') }
  scope :registration_required,
        -> { where(registration_modality: 'registration_required') }

  after_update :send_timing_update_notification,
               if:
                 lambda { |workshop|
                   workshop.saved_change_to_start_time? ||
                     workshop.saved_change_to_end_time?
                 }
  after_update :send_location_update_notification,
               if:
                 lambda { |workshop|
                   workshop.saved_change_to_in_person_location? ||
                     workshop.saved_change_to_virtual_location?
                 }

  def total_attendance
    case attendance_modality
    when 'individual'
      participants.where(in_attendance: true).count
    when 'collective'
      in_person_attendance_count + virtual_attendance_count
    end
  end

  def registration_required
    registration_modality == 'registration_required'
  end

  def application_required
    registration_modality == 'application_required'
  end

  def no_registration_required
    registration_modality == 'no_registration_required'
  end

  private

  def send_timing_update_notification
    participants.each do |participant|
      WorkshopTimingUpdateEmailJob.perform_async(
        { workshop_id: id, participant_id: participant.id }.stringify_keys
      )
    end
  end

  def send_location_update_notification
    participants.each do |participant|
      WorkshopLocationUpdateEmailJob.perform_async(
        { workshop_id: id, participant_id: participant.id }.stringify_keys
      )
    end
  end
end
