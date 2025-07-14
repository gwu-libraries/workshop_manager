# frozen_string_literal: true

class ApplicationQuestionResponsesController < ApplicationController
  def create
    @application_question_response =
      ApplicationQuestionResponse.create(application_question_responses_params)
  end

  def application_question_responses_params
    params.require(:application_question_response).permit(
      :participant_id,
      :application_question_id,
      :value
    )
  end
end
