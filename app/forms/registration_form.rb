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

    # lmao fix this
    @reminder_options =
      params[:reminder_options][:reminder_options].reject { |x| x.empty? }
  end

  def save(params = {})
    return false unless valid?

    participant =
      Participant.create(
        name: @name,
        email: @email,
        workshop_id: @workshop_id,
        application_status: 'accepted'
      )

    RegistrationReceivedEmailJob.perform_async(
      {
        workshop_id: participant.workshop_id,
        participant_id: participant.id
      }.stringify_keys
    )

    if @reminder_options.include? 'One week before'
      ReminderEmailOneWeekJob.perform_at(
        (participant.workshop.start_time - 1.weeks).round,
        {
          workshop_id: participant.workshop_id,
          participant_id: participant.id
        }.stringify_keys
      )
    end

    if @reminder_options.include? 'One day before'
      ReminderEmailOneDayJob.perform_at(
        (participant.workshop.start_time - 1.days).round,
        {
          workshop_id: participant.workshop_id,
          participant_id: participant.id
        }.stringify_keys
      )
    end

    if @reminder_options.include? 'One hour before'
      ReminderEmailOneHourJob.perform_at(
        (participant.workshop.start_time - 1.hours).round,
        {
          workshop_id: participant.workshop_id,
          participant_id: participant.id
        }.stringify_keys
      )
    end
  end
end
