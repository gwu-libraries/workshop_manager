class WorkshopProposalFormsController < ApplicationController
  def create
    @form = WorkshopProposalForm.new(workshop_proposal_form_params)

    respond_to do |format|
      if @form.save
        workshop =
          Workshop.create(
            title: @form.title,
            description: @form.description,
            presentation_modality: @form.presentation_modality,
            attendance_modality: @form.attendance_modality,
            registration_modality: @form.registration_modality,
            virtual_location: @form.virtual_location,
            in_person_location: @form.in_person_location,
            start_time: to_datetime(@form.start_year, 
                                    @form.start_month, 
                                    @form.start_day, 
                                    @form.start_hour, 
                                    @form.start_minute),
            end_time: to_datetime(@form.end_year, 
                                    @form.end_month, 
                                    @form.end_day, 
                                    @form.end_hour, 
                                    @form.end_minute),
            proposal_status: 'pending',
            attachments: @form.attachments
          )

        @form.facilitator_ids.map do |f|
          WorkshopFacilitator.create(workshop_id: workshop.id, facilitator_id: f)
        end

        if @form.registration_modality == 'application_required'
          # this needs to redirect to the application_f
          format.html do
            redirect_to root_url,
                        notice:
                          'Workshop proposal created! An admin will review it.'
          end
        else
          format.html do
            redirect_to root_url,
                        notice:
                          'Workshop proposal created! An admin will review it.'
          end
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def to_datetime(year, month, day, hour, minute)
    DateTime.new(
      year,
      month,
      day,
      hour,
      minute
    )
  end

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
