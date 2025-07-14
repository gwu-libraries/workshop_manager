# frozen_string_literal: true

class ApplicationStatusForm
  include ActiveModel::Model

  # should be reader
  attr_accessor :participant_id, :workshop_id, :application_status

  def initialize(params)
    @participant_id = params[:application_status_form][:participant_id]
    @workshop_id = params[:application_status_form][:workshop_id]
    @application_status = params[:application_status_form][:application_status]
  end

  def save
    true unless invalid?
  end
end
