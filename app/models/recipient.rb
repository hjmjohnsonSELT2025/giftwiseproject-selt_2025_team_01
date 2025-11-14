# frozen_string_literal: true

class Recipient < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :age,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # These could be optional, but you can flip to `presence: true` if desired.
  validates :occupation,  presence: true
  validates :hobbies,     presence: true
  validates :likes,       presence: true
  validates :dislikes,    presence: true

  #tie each recipient to a user
  belongs_to :user

  def full_name
    "#{first_name} #{last_name}"
  end
end
