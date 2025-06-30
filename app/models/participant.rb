# frozen_string_literal: true

class Participant < ApplicationRecord
  enum :application_status,
       { pending: 0, accepted: 1, rejected: 2, waitlisted: 3 }

  belongs_to :workshop
  has_many :application_question_responses

  scope :pending,
        -> { where(application_status: 'pending').order('created_at asc') }
  scope :accepted,
        -> { where(application_status: 'accepted').order('created_at asc') }
  scope :rejected,
        -> { where(application_status: 'rejected').order('created_at asc') }
  scope :waitlisted,
        -> { where(application_status: 'waitlisted').order('created_at asc') }
  scope :in_attendance,
        -> { where(in_attendance: 'true').order('created_at asc') }

  # after_update :send_application_status_notification,
  #              if: lambda(&:saved_change_to_application_status?)

  private

  # def send_application_status_notification
  #   case application_status
  #   when 'accepted'
  #     ApplicationAcceptedEmailJob.perform_async(
  #       {
  #         workshop_id: participant.workshop_id,
  #         participant_id: participant.id
  #       }.stringify_keys
  #     )
  #   when 'rejected'
  #     ApplicationRejectedEmailJob.perform_async(
  #       {
  #         workshop_id: participant.workshop_id,
  #         participant_id: participant.id
  #       }.stringify_keys
  #     )
  #   when 'waitlisted'
  #     ApplicationWaitlistedEmailJob.perform_async(
  #       {
  #         workshop_id: participant.workshop_id,
  #         participant_id: participant.id
  #       }.stringify_keys
  #     )
  #   end
  # end
end
