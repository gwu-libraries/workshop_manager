require 'rails_helper'

RSpec.describe "workshop_participants/new", type: :view do
  before(:each) do
    assign(:workshop_participant, WorkshopParticipant.new())
  end

  it "renders new workshop_participant form" do
    render

    assert_select "form[action=?][method=?]", workshop_participants_path, "post" do
    end
  end
end
