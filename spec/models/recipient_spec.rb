require "rails_helper"

RSpec.describe Recipient, type: :model do
  let(:user) { User.create!(email: "test@example.com", password: "password123", password_confirmation: "password123") }

  subject { described_class.new(name: "Alice", user: user) }

  it "is valid with a name and user" do
    expect(subject).to be_valid
  end

  it "is invalid without a name" do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it "belongs to a user" do
    expect(subject.user).to eq(user)
  end
end
