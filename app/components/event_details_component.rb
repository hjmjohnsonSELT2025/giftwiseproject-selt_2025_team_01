class EventDetailsComponent < ViewComponent::Base
  def initialize(event:)
    @event = event
  end
end
