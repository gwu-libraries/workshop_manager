class RegistrationFormsController < ApplicationController
  def create
    @form = RegistrationForm.new(params)

    respond_to do |format|
      if @form.save
        format.turbo_stream do
          turbo_stream.replace 'registration_form',
                               partial: 'registration_received_notification'
        end
        format.html do
          redirect_to workshop_path(@form.workshop_id),
                      notice:
                        'Your registration was successful! Check your email for more information.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  # def registration_form_params
  #   params.require(:participant_application_form).permit(
  #     :name,
  #     :email,
  #     :workshop_id,
  #   )
  # end
end
