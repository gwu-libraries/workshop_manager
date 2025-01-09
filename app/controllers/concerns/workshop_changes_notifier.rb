module WorkshopChangesNotifier
  extend ActiveSupport::Concern

  included { after_action :workshop_update_notification, only: %i[update] }

  private

  def workshop_update_notification
    if @workshop.save
      @workshop.participants.each do |participant|
        WorkshopUpdateEmailJob.perform_async(
          {
            workshop_id: @workshop.id,
            participant_id: participant.id
          }.stringify_keys
        )
      end
    end
  end
end
