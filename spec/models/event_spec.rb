require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) {User.create!(email: 'user@example.com', password: 'password', password_confirmation: 'password')}

  describe 'associations' do
    it 'belongs to a user' do
      event = Event.new(name: 'Christmas', user: user)
      expect(event.user).to eq(user)
    end
  end

  describe 'validations' do
    it 'is valid with a name and user' do
      event = Event.new(name: 'Christmas', user: user, date: Date.new(2025, 12, 25), description: 'Family gift exchange')
      expect(event).to be_valid
    end

    it 'is not valid without a name' do
      event = Event.new(name: nil, user: user)
      expect(event).not_to be_valid
    end

    it 'is not valid without a user' do
      event = Event.new(name: 'Christmas', user: nil)
      expect(event).not_to be_valid
    end
  end
end