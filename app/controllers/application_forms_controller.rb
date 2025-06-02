class ApplicationFormsController < ApplicationController
  def create
    @form = ApplicationForm.new(params)

    respond_to do |format|
      if @form.save
        format.turbo_stream { turbo_stream.replace 'application_form', 'beep' }
        format.html do
          redirect_to workshop_path(@form.workshop_id),
                      notice:
                        'Your application is pending! Check your email for more information.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  # def application_form_params
  #   params.require(:participant_application_form).permit(
  #     :name,
  #     :email,
  #     :workshop_id,
  #   )
  # end
end
