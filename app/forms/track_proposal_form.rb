# frozen_string_literal: true

class TrackProposalForm
  include ActiveModel::Model

  attr_accessor :title,
                :description,
                :workshop_ids

  def initialize(params)
    @title = params[:title]
    @description = params[:description]
    @workshop_ids = params[:workshop_ids].reject(&:empty?)
  end

  def save
    true unless invalid?
  end
end
