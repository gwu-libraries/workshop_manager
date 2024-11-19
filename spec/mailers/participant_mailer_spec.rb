require 'rails_helper'

RSpec.describe ParticipantMailer, type: :mailer do
  describe 'workshop_registration_email' do
    let(:workshop) { FactoryBot.create(:future_workshop) }
    let(:participant) { FactoryBot.create(:participant) }
    let(:mail) do
      ParticipantMailer.workshop_registration_email(workshop.id, participant.id)
    end

    it 'renders the headers' do
      expect(mail.subject).to eq("Registered for #{workshop.title}")
      expect(mail.to).to eq([participant.email])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(
        "Thank you for registering for #{workshop.title}!"
      )
    end
  end
end
