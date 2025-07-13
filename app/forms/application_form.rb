class ApplicationForm
  include ActiveModel::Model

  attr_accessor :name, 
                :email, 
                :workshop_id,
                :question_ids_and_responses

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

  def save
    return true unless invalid?
  end
end
