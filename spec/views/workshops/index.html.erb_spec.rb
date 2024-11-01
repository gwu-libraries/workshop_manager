require 'rails_helper'

RSpec.describe "workshops/index", type: :view do
  before(:each) do
    assign(:workshops, [
      Workshop.create!(),
      Workshop.create!()
    ])
  end

  it "renders a list of workshops" do
    render
    cell_selector = 'div>p'
  end
end
