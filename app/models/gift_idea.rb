class GiftIdea < ApplicationRecord
  belongs_to :recipient

  validates :title, presence: true
end
