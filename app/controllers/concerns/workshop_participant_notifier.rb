module WorkshopParticipantNotifier
  extend ActiveSupport::Concern

  included do
    after_action :workshop_participant_registration_notification,
                 only: [:create]
  end

  private

  def workshop_participant_registration_notification
    if @workshop_participant.persisted?
      puts "Emailing #{@workshop_participant.participant.email}"

      ParticipantMailer.workshop_registration_email(
        @workshop_participant.workshop,
        @workshop_participant.participant
      ).deliver_later
    end
  end
end
