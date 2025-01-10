class WorkshopParticipant < ApplicationRecord
  enum :application_status,
       { pending: 0, accepted: 1, rejected: 2, waitlisted: 3 }

  belongs_to :workshop
  belongs_to :participant

  after_update :send_application_status_notification,
               if: ->(workshop_participant) do
                 workshop_participant.saved_change_to_application_status?
               end

  private

  def send_application_status_notification
    case self.application_status
    when 'accepted'
      ApplicationAcceptedEmailJob.perform_async(
        {
          workshop_id: self.workshop.id,
          participant_id: self.participant.id
        }.stringify_keys
      )
    when 'rejected'
      ApplicationRejectedEmailJob.perform_async(
        {
          workshop_id: self.workshop.id,
          participant_id: self.participant.id
        }.stringify_keys
      )
    when 'waitlisted'
      ApplicationWaitlistedEmailJob.perform_async(
        {
          workshop_id: self.workshop.id,
          participant_id: self.participant.id
        }.stringify_keys
      )
    end
  end
end
