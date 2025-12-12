class RecipientCardComponent < ViewComponent::Base
  def initialize(recipient:, bg_color:)
    @recipient = recipient
    @bg_color = bg_color
  end
end
