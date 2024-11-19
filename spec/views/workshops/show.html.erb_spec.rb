require 'rails_helper'

RSpec.describe 'workshops/show', type: :view do
  before(:each) { assign(:workshop, FactoryBot.create(:future_workshop)) }

  xit 'renders attributes in <p>' do
    render
  end
end
