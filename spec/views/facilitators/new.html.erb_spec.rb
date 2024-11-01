require 'rails_helper'

RSpec.describe "facilitators/new", type: :view do
  before(:each) do
    assign(:facilitator, Facilitator.new())
  end

  it "renders new facilitator form" do
    render

    assert_select "form[action=?][method=?]", facilitators_path, "post" do
    end
  end
end
