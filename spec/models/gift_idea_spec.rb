require 'rails_helper'

RSpec.describe GiftIdea, type: :model do
  let(:user) do
    User.create!(
      email: "user@example.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  let(:recipient) do
    Recipient.create!(
      name: "Mom",
      user: user
    )
  end

  describe "associations" do
    it "belongs to recipient" do
      gift = GiftIdea.new(title: "coffee maker", recipient: recipient)
      expect(gift.recipient).to eq(recipient)
    end
  end

  describe "validations" do
    it "is valid with title and recipient" do
      gift = GiftIdea.new(
        title: "Coffee maker",
        notes: "On sale",
        url: "https://example.com",
        recipient: recipient
      )
      expect(gift).to be_valid
    end

    it "is not valid without title" do
      gift = GiftIdea.new(
        title: nil,
        recipient: recipient
      )
      expect(gift).not_to be_valid
    end

    it "is not valid without recipient" do
      gift = GiftIdea.new(
        title: "Coffee maker",
        recipient: nil
      )
      expect(gift).not_to be_valid
    end
  end

end
