class EventRecipient < ApplicationRecord
  # [MODEL] Join Table Association.
  # This is a "linking" model that connects Events and Recipients.
  # Each record represents a single Recipient assigned to a single Event.

  belongs_to :event # Each EventRecipient belongs to one Event
  belongs_to :recipient # Each EventRecipient belongs to one Recipient

  # Prevents assigning the same recipient to the same event more than once.
  # Enforces that each (event_id, recipient_id) pair is unique.
  validates :event_id, uniqueness: { scope: :recipient_id }
end
