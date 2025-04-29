# frozen_string_literal: true

class ApplicationFormsController < ApplicationController
  before_action :require_login, only: %i[show]
  def show
    @application_form = ApplicationForm.find(application_forms_params[:id])
  end

  private

  def application_forms_params
    params.permit(:id)
  end
end
