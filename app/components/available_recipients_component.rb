class AvailableRecipientsComponent < ViewComponent::Base
  def initialize(event:, recipients:)
    @event = event
    @recipients = recipients
  end
end
