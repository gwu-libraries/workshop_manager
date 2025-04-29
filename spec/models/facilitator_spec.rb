# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Facilitator, type: :model do
  describe 'relationships' do
    it { should have_many :workshop_facilitators }
    it { should have_many(:workshops).through(:workshop_facilitators) }
  end
end
