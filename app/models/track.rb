# frozen_string_literal: true

class Track < ApplicationRecord
  has_many :track_workshops
  has_many :workshops, through: :track_workshops

  enum :proposal_status, { pending: 0, approved: 1, rejected: 2 }

  scope :pending, -> { where(proposal_status: 'pending') }
  scope :approved, -> { where(proposal_status: 'approved') }
  scope :rejected, -> { where(proposal_status: 'rejected') }
end
