require 'rails_helper'

RSpec.describe "facilitators/edit", type: :view do
  let(:facilitator) {
    Facilitator.create!()
  }

  before(:each) do
    assign(:facilitator, facilitator)
  end

  it "renders the edit facilitator form" do
    render

    assert_select "form[action=?][method=?]", facilitator_path(facilitator), "post" do
    end
  end
end
