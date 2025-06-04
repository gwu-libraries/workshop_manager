class ApplicationStatusForm
  include ActiveModel::Model

  attr_accessor :participant_id, :workshop_id, :application_status

  def initialize(params)
    @participant_id = params[:participant_id]
    @workshop_id = params[:workshop_id]
    @application_status = params[:application_status]
  end

  def save(params = {})
    return false unless valid?

    participant = Participant.find(@participant_id)

    participant.update(application_status: @application_status)
  end
end
