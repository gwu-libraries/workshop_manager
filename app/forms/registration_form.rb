class RegistrationForm
  include ActiveModel::Model

  attr_accessor :name, :email, :workshop_id

  validates :name, presence: true
  validates :email, presence: true
  validates :workshop_id, presence: true

  def initialize(params)
    @name = params[:registration_form][:name]
    @email = params[:registration_form][:email]
    @workshop_id = params[:registration_form][:workshop_id]
    @reminder_options = params[:registration_form][:reminder_options]
  end

  def save(params = {})
    return false unless valid?

    Participant.create(
      name: @name,
      email: @email,
      workshop_id: @workshop_id,
      application_status: 'accepted'
    )
  end
end
