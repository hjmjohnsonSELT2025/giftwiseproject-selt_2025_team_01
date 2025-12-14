class GiftIdeaCardComponent < ViewComponent::Base
  def initialize(gift_idea:, recipient: nil, event_recipient: nil)
    @gift_idea = gift_idea
    @recipient = recipient
    @event_recipient = event_recipient
  end

  def edit_path
    if @recipient
      edit_recipient_gift_idea_path(@recipient, @gift_idea)
    elsif @event_recipient
      edit_event_recipient_gift_idea_path(@event_recipient.event, @event_recipient.recipient, @gift_idea)
    end
  end

  def delete_path
    if @recipient
      recipient_gift_idea_path(@recipient, @gift_idea)
    elsif @event_recipient
      event_recipient_gift_idea_path(@event_recipient.event, @event_recipient.recipient, @gift_idea)
    end
  end

  def gift_url
    @gift_idea.url.presence
  end
end
