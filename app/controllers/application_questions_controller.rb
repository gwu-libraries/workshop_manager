# frozen_string_literal: true

class ApplicationQuestionsController < ApplicationController
  def create
    @application_question =
      ApplicationQuestion.create(application_question_params)

    respond_to do |format|
      if @application_question.save
        format.turbo_stream do
          render turbo_stream:
                   turbo_stream.append(
                     'application_questions',
                     partial: 'application_question',
                     locals: {
                       question: @application_question
                     }
                   )
        end
      end
    end
  end

  private

  def application_question_params
    params.require(:application_question).permit(
      :workshop_id,
      :prompt,
      :question_format
    )
  end
end
