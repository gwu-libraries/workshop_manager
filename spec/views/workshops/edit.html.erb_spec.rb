require 'rails_helper'

RSpec.describe "workshops/edit", type: :view do
  let(:workshop) {
    Workshop.create!()
  }

  before(:each) do
    assign(:workshop, workshop)
  end

  it "renders the edit workshop form" do
    render

    assert_select "form[action=?][method=?]", workshop_path(workshop), "post" do
    end
  end
end
