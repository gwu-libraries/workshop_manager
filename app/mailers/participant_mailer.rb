class ParticipantMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.participant_mailer.workshop_registration_email.subject
  #
  def workshop_registration_email(workshop, participant)
    @workshop = workshop
    @participant = participant
    @greeting = 'Hi'

    mail(to: @participant.email, subject: "Registered for #{@workshop.title}")
  end
end
