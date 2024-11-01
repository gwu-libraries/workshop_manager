require 'rails_helper'

RSpec.describe "facilitators/show", type: :view do
  before(:each) do
    assign(:facilitator, Facilitator.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
