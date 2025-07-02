class WorkshopProposalForm
  include ActiveModel::Model

  attr_reader :registration_modality

  def initialize(params)
    @title = params[:title]
    @description = params[:description]
    @presentation_modality = params[:presentation_modality]
    @attendance_modality = params[:attendance_modality]
    @registration_modality = params[:registration_modality]
    @virtual_location = params[:virtual_location]
    @in_person_location = params[:in_person_location]

    @start_year = params['start_time(1i)'].to_i
    @start_month = params['start_time(2i)'].to_i
    @start_day = params['start_time(3i)'].to_i
    @start_hour = params['start_time(4i)'].to_i
    @start_minute = params['start_time(5i)'].to_i

    @end_year = params['end_time(1i)'].to_i
    @end_month = params['end_time(2i)'].to_i
    @end_day = params['end_time(3i)'].to_i
    @end_hour = params['end_time(4i)'].to_i
    @end_minute = params['end_time(5i)'].to_i

    @facilitator_ids =
      params[:facilitator_ids].reject { |x| x.empty? }.map { |x| x.to_i }

    @attachments = params[:attachments].reject {|x| x == "" }
  end

  def save(params = {})
    return false unless valid?

    workshop =
      Workshop.create(
        title: @title,
        description: @description,
        presentation_modality: @presentation_modality,
        attendance_modality: @attendance_modality,
        registration_modality: @registration_modality,
        virtual_location: @virtual_location,
        in_person_location: @in_person_location,
        start_time: start_datetime,
        end_time: end_datetime,
        proposal_status: 'pending',
        attachments: @attachments
      )

    @facilitator_ids.map do |f|
      WorkshopFacilitator.create(workshop_id: workshop.id, facilitator_id: f)
    end
  end

  private

  def start_datetime
    DateTime.new(
      @start_year,
      @start_month,
      @start_day,
      @start_hour,
      @start_minute
    )
  end

  def end_datetime
    DateTime.new(@end_year, @end_month, @end_day, @end_hour, @end_minute)
  end
end
