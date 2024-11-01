require 'rails_helper'

RSpec.describe "facilitators/index", type: :view do
  before(:each) do
    assign(:facilitators, [
      Facilitator.create!(),
      Facilitator.create!()
    ])
  end

  it "renders a list of facilitators" do
    render
    cell_selector = 'div>p'
  end
end
