require 'rails_helper'

RSpec.describe "participants/edit", type: :view do
  let(:participant) {
    Participant.create!()
  }

  before(:each) do
    assign(:participant, participant)
  end

  it "renders the edit participant form" do
    render

    assert_select "form[action=?][method=?]", participant_path(participant), "post" do
    end
  end
end
