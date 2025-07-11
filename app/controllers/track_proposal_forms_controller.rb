class TrackProposalFormsController < ApplicationController
  def create
    @form = TrackProposalForm.new(track_proposal_form_params)

    respond_to do |format|
      if @form.save

        track =
          Track.create(
            title: @form.title,
            description: @form.description,
            proposal_status: 'pending'
          )

        @form.workshop_ids.map do |w|
          TrackWorkshop.create(track_id: track.id, workshop_id: w)
        end
        format.html do
          redirect_to root_url,
                      notice: 'Track proposal created! An admin will review it.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def track_proposal_form_params
    params.require(:track_proposal_form).permit(
      :title,
      :description,
      workshop_ids: []
    )
  end
end
