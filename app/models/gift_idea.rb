class GiftIdea < ApplicationRecord
  belongs_to :recipient
  belongs_to :user

  validates :title, presence: true
end