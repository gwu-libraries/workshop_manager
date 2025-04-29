# frozen_string_literal: true

class FeedbackFormsController < ApplicationController
  before_action :set_feedback_form, only: %i[show edit]
  before_action :require_login, only: %i[edit new]

  def show; end

  def edit; end

  def new; end

  private

  def feedback_forms_params
    params.permit(:id)
  end

  def set_feedback_form
    @feedback_form = FeedbackForm.find(params[:id])
  end
end
