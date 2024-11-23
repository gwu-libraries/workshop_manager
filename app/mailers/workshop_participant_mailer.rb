class WorkshopParticipantMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.workshop_participant_mailer.workshop_registration_email.subject
  #
  def workshop_registration_email(workshop, participant)
    @workshop = workshop
    @participant = participant

    @greeting = 'Hi'

    mail(
      to: @participant.email,
      subject: "You've registered for #{@workshop.title}"
    )
  end
end
