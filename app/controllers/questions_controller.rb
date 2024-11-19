class QuestionsController < ApplicationController
  def show
    @question = Question.find(question_params[:id])
  end
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question =
      Question.create(question_params.except(:application_template_id))

    if @question.save
      ApplicationTemplateQuestion.create(
        question_id: @question.id,
        application_template_id: question_params[:application_template_id]
      )
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
      :application_template_id,
      :prompt,
      :question_format
    )
  end
end
