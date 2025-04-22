class ApplicationTemplatesController < ApplicationController
  before_action :require_login, only: %i[show]
  def show
    @application_template =
      ApplicationTemplate.find(application_templates_params[:id])
  end

  private

  def application_templates_params
    params.permit(:id)
  end
end
