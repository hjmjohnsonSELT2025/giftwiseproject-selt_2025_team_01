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
end