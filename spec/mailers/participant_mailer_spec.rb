require "rails_helper"

RSpec.describe ParticipantMailer, type: :mailer do
  describe "workshop_registration_email" do
    let(:mail) { ParticipantMailer.workshop_registration_email }

    it "renders the headers" do
      expect(mail.subject).to eq("Workshop registration email")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
