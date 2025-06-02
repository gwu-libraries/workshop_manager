class WorkshopProposalFormsController < ApplicationController
  def create
    @form = WorkshopProposalForm.new(workshop_proposal_form_params)

    respond_to do |format|
      if @form.save
        format.html do
          redirect_to root_url,
                      notice:
                        'Workshop proposal created! An admin will review it.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def workshop_proposal_form_params
    params.require(:workshop_proposal_form).permit(
      :title,
      :description,
      :start_time,
      :end_time,
      :location,
      :attendance_modality,
      :presentation_modality,
      :registration_modality,
      :in_person_location,
      :virtual_location,
      :proposal_status,
      :in_person_attendance_count,
      :virtual_attendance_count,
      attachments: [],
      facilitator_ids: []
    )
  end
end
