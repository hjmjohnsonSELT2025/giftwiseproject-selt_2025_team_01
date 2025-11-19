class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: { message: "This Email is already in use" }
  validates :password, length: { minimum: 6 }

  # recipient-related stuff
  has_many :events, dependent: :destroy
  has_many :recipients, dependent: :destroy
end
