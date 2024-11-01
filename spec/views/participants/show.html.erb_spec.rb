require 'rails_helper'

RSpec.describe "participants/show", type: :view do
  before(:each) do
    assign(:participant, Participant.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
