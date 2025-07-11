class TrackProposalForm
  include ActiveModel::Model

  def initialize(params)
    @title = params[:title]
    @description = params[:description]
    @workshop_ids = params[:workshop_ids].reject { |x| x.empty? }
  end

  def save
    return true unless invalid?

    track =
      Track.create(
        title: @title,
        description: @description,
        proposal_status: 'pending'
      )

    @workshop_ids.map do |w|
      TrackWorkshop.create(track_id: track.id, workshop_id: w)
    end
  end
end
