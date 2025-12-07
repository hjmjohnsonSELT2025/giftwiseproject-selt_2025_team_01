require 'rails_helper'

Rspec.describe "GiftIdeas", type: :request do
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


  def log_in_as(u)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(u)
  end

  before do
    # default: logged out
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(u)
  end

  describe "GET /recipients/:recipient_id/gift_ideas" do

  end


end