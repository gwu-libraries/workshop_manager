# frozen_string_literal: true

class QuestionsController < ApplicationController
  def create
    @question =
      Question.create(
        question_params.except(:application_form_id, :feedback_form_id)
      )

    if @question.save
      if question_params[:application_form].present?
        ApplicationFormQuestion.create(
          question_id: @question.id,
          application_form_id: question_params[:application_form_id]
        )
      end

      if question_params[:feedback_form_id].present?
        FeedbackFormQuestion.create(
          question_id: @question.id,
          feedback_form_id: question_params[:feedback_form_id]
        )
      end
    end

    respond_to do |format|
      if @question.save
        format.turbo_stream do
          render turbo_stream:
                   turbo_stream.append(
                     'questions',
                     partial: 'question',
                     locals: {
                       question: @question
                     }
                   )
        end
      end
    end
  end

  private

  def question_params
    params.require(:question).permit(
      :application_form_id,
      :feedback_form_id,
      :prompt,
      :question_format
    )
  end
end
