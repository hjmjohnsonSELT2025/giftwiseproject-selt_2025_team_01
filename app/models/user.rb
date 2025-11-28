class User < ApplicationRecord
  # [MODEL & SECURITY] Built-in Rails method for authentication.
  # 1. Adds virtual attributes 'password' and 'password_confirmation'.
  # 2. Validates that they match.
  # 3. Hashes the password and stores it in the 'password_digest' database column.
  # Used by SessionsController to verify login credentials via the 'authenticate' method.
  has_secure_password

  # [MODEL] Data Integrity Validations.
  # Ensures emails are present and unique in the database before saving.
  # Prevents duplicate accounts.
  validates :email, presence: true, uniqueness: { message: "This Email is already in use" }

  # Enforces a minimum password complexity policy.
  validates :password, length: { minimum: 6 }, if: :should_validate_password?

  # [MODEL] Database Association.
  # Defines a one-to-many relationship: One User can have multiple Recipients.
  # Define relationship, each recipient has one profile associated
  # 'dependent: :destroy' ensures that if a User is deleted,
  # all their associated Recipient records are automatically deleted from the database
  # to prevent orphaned data.
  has_one :profile, dependent: :destroy
  has_many :recipients, dependent: :destroy
  has_many :events, dependent: :destroy

  # Only validates password on:
  # - User creation
  # - Password update
  def should_validate_password?
    password.present? || new_record?
  end
end