class RecipientCardComponent < ViewComponent::Base
  def initialize(recipient:, index:)
    @recipient = recipient
    @index = index
  end
end
