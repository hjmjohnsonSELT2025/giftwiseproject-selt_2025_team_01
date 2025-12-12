class EventCardComponent < ViewComponent::Base
  def initialize(event:)
    @event = event
  end
end
