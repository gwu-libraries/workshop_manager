# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'feedback form email job', type: :job do
  before do
    @facilitator_1 = FactoryBot.create(:facilitator)

    @workshop_1 = FactoryBot.create(:future_application_workshop)

    @participant_1 =
      FactoryBot.create(:participant, workshop_id: @workshop_1.id)
  end
end
