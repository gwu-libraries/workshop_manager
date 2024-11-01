require 'rails_helper'

RSpec.describe "workshops/show", type: :view do
  before(:each) do
    assign(:workshop, Workshop.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
