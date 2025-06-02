# frozen_string_literal: true

class FeedbackQuestionsController < ApplicationController
  def create
    @feedback_question = FeedbackQuestion.create(feedback_form_question_params)

    respond_to do |format|
      if @feedback_question.save
        format.turbo_stream do
          render turbo_stream:
                   turbo_stream.append(
                     'feedback_questions',
                     partial: 'feedback_question',
                     locals: {
                       question: @feedback_question
                     }
                   )
        end
      end
    end
  end

  private

  def feedback_question_params
    params.require(:feedback_question).permit(
      :workshop_id,
      :prompt,
      :question_format
    )
  end
end
