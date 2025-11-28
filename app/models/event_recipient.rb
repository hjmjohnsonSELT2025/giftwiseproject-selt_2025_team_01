class EventRecipient < ApplicationRecord
  # [MODEL] Join Table Association.
  # This is a "linking" model that connects Events and Recipients.
  # Each record represents a single Recipient assigned to a single Event.

  belongs_to :event # Each EventRecipient belongs to one Event
  belongs_to :recipient # Each EventRecipient belongs to one Recipient
end
