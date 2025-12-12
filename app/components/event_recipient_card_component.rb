class EventRecipientCardComponent < ViewComponent::Base
  def initialize(event:, recipient:)
    @event = event
    @recipient = recipient
    @event_recipient = recipient.event_recipient_for(event)
  end
end
