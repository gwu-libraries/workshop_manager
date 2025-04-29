# frozen_string_literal: true

class ApplicationFormsController < ApplicationController
  before_action :require_login, only: %i[show edit]
  before_action :set_application_form, only: %i[show edit]

  def show
  end

  def edit
  end

  private

  def set_application_form
    @application_form = ApplicationForm.find(application_forms_params[:id])
  end

  def application_forms_params
    params.permit(:id)
  end
end
