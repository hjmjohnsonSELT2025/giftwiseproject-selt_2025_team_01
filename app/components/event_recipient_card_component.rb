class EventRecipientCardComponent < ViewComponent::Base
  attr_reader :event, :recipient, :event_recipient, :action

  def initialize(event:, recipient:, action: :remove)
    @event = event
    @recipient = recipient
    @event_recipient = recipient.event_recipient_for(event)
    @action = action
  end
end
