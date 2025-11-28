class Event < ApplicationRecord
  # [MODEL] Database Association.
  # Each Event belongs to one User, expects a 'user_id' column in the 'events' table as the foreign key.
  belongs_to :user

  # [MODEL] Database Association for many-to-many relationship with Recipients.
  # Uses the EventRecipient join table to associate multiple Recipients to an Event.
  # 'has_many :event_recipients' gives access to the join table records for this event.
  # 'has_many :recipients, through: :event_recipients' allows direct access to the associated recipients.
  has_many :event_recipients
  has_many :recipients, through: :event_recipients

  # [MODEL] Data Validations
  # presence: true - forces this field to be filled out.
  validates :name, presence: true
  validates :date, presence: true
  validates :budget, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true # numericality - forcing values to be positive. allow_nil - allow it to be blank if not specified

  # Note: description, theme, budget, etc. are optional fields and can be left blank.
end
