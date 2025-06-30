class ApplicationForm
  include ActiveModel::Model

  attr_accessor :name, :email, :workshop_id

  validates :name, presence: true
  validates :email, presence: true
  validates :workshop_id, presence: true

  def initialize(params)
    @name = params[:application_form][:name]
    @email = params[:application_form][:email]
    @workshop_id = params[:application_form][:workshop_id]
    @question_ids_and_responses = {}

    params[:application_form]
      .except(:name, :email, :workshop_id)
      .each { |k, v| @question_ids_and_responses[k] = v }
  end

  def save(params = {})
    return false unless valid?

    participant =
      Participant.create(
        name: @name,
        email: @email,
        workshop_id: @workshop_id,
        application_status: 'pending'
      )

    @question_ids_and_responses.each do |question_id, response|
      ApplicationQuestionResponse.create(
        application_question_id: question_id,
        participant_id: participant.id,
        value: response
      )
    end

    ApplicationReceivedEmailJob.perform_async(
      {
        workshop_id: participant.workshop_id,
        participant_id: participant.id
      }.stringify_keys
    )
  end
end
