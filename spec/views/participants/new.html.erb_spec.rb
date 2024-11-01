require 'rails_helper'

RSpec.describe "participants/new", type: :view do
  before(:each) do
    assign(:participant, Participant.new())
  end

  it "renders new participant form" do
    render

    assert_select "form[action=?][method=?]", participants_path, "post" do
    end
  end
end
