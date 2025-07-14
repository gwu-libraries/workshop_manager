# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ParticipantMailer, type: :mailer do
  describe 'registration_received_email' do
    let(:workshop) { FactoryBot.create(:future_workshop) }
    let(:participant) do
      FactoryBot.create(:participant, workshop_id: workshop.id)
    end
    let(:mail) do
      described_class.registration_received_email(workshop.id, participant.id)
    end

    it 'renders the headers' do
      expect(mail.subject).to eq("Registered for #{workshop.title}")
      expect(mail.to).to eq([participant.email])
      expect(mail.from).to eq(['from@example.com'])
    end
  end
end
