require 'rails_helper'

RSpec.describe "workshops/new", type: :view do
  before(:each) do
    assign(:workshop, Workshop.new())
  end

  it "renders new workshop form" do
    render

    assert_select "form[action=?][method=?]", workshops_path, "post" do
    end
  end
end
