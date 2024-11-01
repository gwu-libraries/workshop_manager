require 'rails_helper'

RSpec.describe "workshop_participants/edit", type: :view do
  let(:workshop_participant) {
    WorkshopParticipant.create!()
  }

  before(:each) do
    assign(:workshop_participant, workshop_participant)
  end

  it "renders the edit workshop_participant form" do
    render

    assert_select "form[action=?][method=?]", workshop_participant_path(workshop_participant), "post" do
    end
  end
end
