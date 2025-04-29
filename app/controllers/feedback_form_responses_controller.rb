class FeedbackFormResponsesController < ApplicationController
  def create
    feedback_form_responses = {}

    params[:feedback_form_response]
      .except(:feedback_form_id)
      .each { |key, value| feedback_form_responses[key] = value }

    FeedbackFormResponse.create(
      feedback_form_id: params[:feedback_form_response][:feedback_form_id],
      response_data: feedback_form_responses
    )

    redirect_to workshops_path, notice: 'Thank you for your feedback!'
  end

  private

  # def feedback_form_responses_params
  #   params.permit(:feedback_form_id, :feedback_form_response)
  # end
end
