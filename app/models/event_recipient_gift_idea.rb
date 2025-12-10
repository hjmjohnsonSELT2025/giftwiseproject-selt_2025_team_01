class EventRecipientGiftIdea < ApplicationRecord
  belongs_to :event_recipient

  validates :title, presence: true

  # DRY solution for URL-validation logic both here & event-specific gifts
  # see concerns/url_validatable.rb for how this works
  include UrlValidatable
end
