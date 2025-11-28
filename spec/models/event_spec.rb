require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) do
    User.create!(
      email: "user@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  describe "associations" do
    it "belongs to a user" do
      event = Event.new(user: user, name: "Birthday", date: Date.today)
      expect(event.user).to eq(user)
    end

    it "has many event_recipients" do
      event = Event.new(user: user, name: "Birthday", date: Date.today)
      expect(event).to respond_to(:event_recipients)
    end

    it "has many recipients through event_recipients" do
      event = Event.new(user: user, name: "Birthday", date: Date.today)
      expect(event).to respond_to(:recipients)
    end
  end

  describe "validations" do
    it "is valid with required attributes" do
      event = Event.new(
        user: user,
        name: "Birthday Party",
        date: Date.today,
        description: "Party at home",
        theme: "Blue",
        budget: 100.0
      )
      expect(event).to be_valid
    end

    it "is invalid without a name" do
      event = Event.new(user: user, date: Date.today)
      expect(event).not_to be_valid
      expect(event.errors[:name]).to be_present
    end

    it "is invalid without a date" do
      event = Event.new(user: user, name: "Birthday")
      expect(event).not_to be_valid
      expect(event.errors[:date]).to be_present
    end

    it "allows nil budget" do
      event = Event.new(user: user, name: "Birthday", date: Date.today, budget: nil)
      expect(event).to be_valid
    end

    it "is invalid with a negative budget" do
      event = Event.new(user: user, name: "Birthday", date: Date.today, budget: -10)
      expect(event).not_to be_valid
      expect(event.errors[:budget]).to be_present
    end

    it "is valid with zero or positive budget" do
      zero_budget = Event.new(user: user, name: "Birthday", date: Date.today, budget: 0)
      positive_budget = Event.new(user: user, name: "Birthday", date: Date.today, budget: 50)

      expect(zero_budget).to be_valid
      expect(positive_budget).to be_valid
    end
  end
end
