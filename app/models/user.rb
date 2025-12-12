class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 github]

  # [MODEL] Database Association.
  # Defines a one-to-many relationship: One User can have multiple Recipients.
  # Define relationship, each recipient has one profile associated
  # 'dependent: :destroy' ensures that if a User is deleted,
  # all their associated Recipient records are automatically deleted from the database
  # to prevent orphaned data.
  has_one :profile, dependent: :destroy
  has_many :recipients, dependent: :destroy
  has_many :events, dependent: :destroy

  # Devise OmniAuth callback handler
  def self.from_omniauth(auth)
    # Try to find user by provider and uid first
    user = where(provider: auth.provider, uid: auth.uid).first

    # If not found, try to find by email
    user ||= find_by(email: auth.info.email)

    # If user found by email but no provider/uid, update them
    if user
      user.update(provider: auth.provider, uid: auth.uid) if user.provider.nil? || user.uid.nil?
      return user
    end

    # Otherwise, create new user
    create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.avatar_url = auth.info.image
      user.name = auth.info.name
      user.provider = auth.provider
      user.uid = auth.uid
    end
  end

end