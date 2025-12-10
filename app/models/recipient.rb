class Recipient < ApplicationRecord
  # [MODEL] Database Association.
  # Links this Recipient to a single User record.
  # This expects a 'user_id' column in the 'recipients' database table (Foreign Key).
  belongs_to :user

  # [MODEL] Data Validations.
  # These rules are checked by the Controller (e.g., in create/update actions)
  # before any data is committed to the database.

  # Ensures a name is always provided.
  validates :name, presence: true

  # Ensures age is a number if it is provided (optional field).
  validates :age, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  # Limits the length of the relationship text to prevent database overflow or UI issues.
  validates :relationship, length: { maximum: 100 }, allow_blank: true

  # [MODEL] Database Association for many-to-many relationship with Events.
  # Uses the EventRecipient join table to associate multiple Events to a Recipient.
  # 'has_many :event_recipients' gives access to the join table records for this recipient.
  # 'has_many :events, through: :event_recipients' allows direct access to the associated events.
  has_many :event_recipients
  has_many :events, through: :event_recipients
  has_many :gift_ideas, dependent: :destroy
end