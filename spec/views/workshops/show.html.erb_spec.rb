require 'rails_helper'

RSpec.describe 'workshops/show', type: :view do
  before(:each) { assign(:workshop, FactoryBot.create(:future_workshop)) }

  it 'renders attributes in <p>' do
    render
  end
end
