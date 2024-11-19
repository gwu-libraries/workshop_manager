class ApplicationTemplatesController < ApplicationController
  def show
    @application_template =
      ApplicationTemplate.find(application_templates_params[:id])
  end

  private

  def application_templates_params
    params.permit(:id)
  end
end
