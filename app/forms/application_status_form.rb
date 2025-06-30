class ApplicationStatusForm
  include ActiveModel::Model

  attr_accessor :participant_id, :workshop_id, :application_status

  def initialize(params)
    @participant_id = params[:application_status_form][:participant_id]
    @workshop_id = params[:application_status_form][:workshop_id]
    @application_status = params[:application_status_form][:application_status]
  end

  def save
    return false unless valid?

    participant = Participant.find(@participant_id)

    participant.update(application_status: @application_status)

    send_application_status_notification
  end

  def send_application_status_notification
    case @application_status
    when 'accepted'
      ApplicationAcceptedEmailJob.perform_async(
        {
          workshop_id: @workshop_id,
          participant_id: @participant_id
        }.stringify_keys
      )
    when 'rejected'
      ApplicationRejectedEmailJob.perform_async(
        {
          workshop_id: @workshop_id,
          participant_id: @participant_id
        }.stringify_keys
      )
    when 'waitlisted'
      ApplicationWaitlistedEmailJob.perform_async(
        {
          workshop_id: @workshop_id,
          participant_id: @participant_id
        }.stringify_keys
      )
    end
  end
end
