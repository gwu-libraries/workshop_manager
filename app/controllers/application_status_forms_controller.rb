class ApplicationStatusFormsController < ApplicationController
  # include FeedbackEmailScheduler

  def create
    @form = ApplicationStatusForm.new(params)

    respond_to do |format|
      if @form.save
        format.turbo_stream do
          turbo_stream.destroy "participant_application_status_form_#{@form.participant_id}"
        end
        format.html { redirect_to workshop_path(@form.workshop_id) }
      end
    end
  end
end
