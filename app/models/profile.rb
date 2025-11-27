class Profile < ApplicationRecord
  belongs_to :user

  # validates :name, presence: true
  validates :name, presence: true, allow_blank: true
  validates :age, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  validates :occupation, length: { maximum: 100 }, allow_blank: true
  validates :hobbies, length: { maximum: 500 }, allow_blank: true
  validates :likes, length: { maximum: 500 }, allow_blank: true
  validates :dislikes, length: { maximum: 500 }, allow_blank: true
end
