require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the WorkshopsHelper. For example:
#
# describe WorkshopsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe WorkshopsHelper, type: :helper do
  describe 'human readable start_date' do
    it 'converts a datetime into a human readable time' do
      dt = DateTime.new(2001, 2, 3, 4, 5, 6)

      formatted_time = human_readable_time(dt)

      expect(formatted_time).to eq('4:05 AM')
    end
  end

  describe 'human readable date' do
    it 'converts a datetime into a human readable date' do
      dt = DateTime.new(2001, 2, 3, 4, 5, 6)

      formatted_date = human_readable_date(dt)

      expect(formatted_date).to eq('Saturday, February 3, 2001')
    end
  end
end
