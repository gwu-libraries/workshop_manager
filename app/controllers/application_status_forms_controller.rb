class ApplicationStatusFormsController < ApplicationController
  def create
    @form = ApplicationStatusForm.new(params)

    respond_to do |format|
      if @form.save
        format.turbo_stream do
          turbo_stream.destroy "participant_application_status_form_#{params[:participant_id]}"
        end
        format.html { redirect_to workshop_path(params[:workshop_id]) }
      end
    end
  end
end
