class Recipient < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :age, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :relationship, length: { maximum: 100 }, allow_blank: true
end