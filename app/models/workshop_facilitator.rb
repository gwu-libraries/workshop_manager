class WorkshopFacilitator < ApplicationRecord
  belongs_to :workshop
  belongs_to :facilitator
end
