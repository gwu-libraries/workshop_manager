# frozen_string_literal: true

class RegistrationForm
  include ActiveModel::Model

  attr_accessor :name,
                :email,
                :workshop_id,
                :reminder_options

  validates :name, presence: true
  validates :email, presence: true
  validates :workshop_id, presence: true

  def initialize(params)
    @name = params[:registration_form][:name]
    @email = params[:registration_form][:email]
    @workshop_id = params[:registration_form][:workshop_id]

    # lmao fix this
    @reminder_options =
      params[:reminder_options][:reminder_options].reject(&:empty?)
  end

  def save
    true unless invalid?
  end
end
