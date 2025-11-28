module EventsHelper
  def formatted_event_date(event)
    event.date.strftime("%Y-%m-%d")
  end
end