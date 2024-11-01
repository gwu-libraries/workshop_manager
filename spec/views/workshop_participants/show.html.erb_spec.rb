require 'rails_helper'

RSpec.describe "workshop_participants/show", type: :view do
  before(:each) do
    assign(:workshop_participant, WorkshopParticipant.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
