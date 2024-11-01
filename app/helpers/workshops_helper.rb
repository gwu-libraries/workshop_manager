module WorkshopsHelper
  def human_readable_time(datetime)
    datetime.strftime('%l:%M %p').strip
  end

  def human_readable_date(datetime)
    datetime.strftime('%A, %B%e, %Y').strip
  end
end
