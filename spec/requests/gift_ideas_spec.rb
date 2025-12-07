require 'rails_helper'

RSpec.describe "GiftIdeas", type: :request do
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
    post login_path, params: {
      email: u.email,
      password: "password"
    }
  end



  describe "GET /recipients/:recipient_id/gift_ideas" do
    it "redirects to login when not logged in" do
      get new_recipient_gift_idea_path(recipient)
      expect(response).to redirect_to(login_path)
    end

    it "returns success when logged in" do
      log_in_as(user)

      get new_recipient_gift_idea_path(recipient)


      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Mom")
    end
  end

  describe "POST /recipients/:recipient_id/gift_ideas" do
    it "redirects to login when not logged in" do
      post recipient_gift_ideas_path(recipient), params: {
        gift_idea: {
          title: "New Gift",
          description: "Description"
        }
      }

      expect(response).to redirect_to(login_path)
    end

    it "creates a new gift idea when logged in" do
      log_in_as(user)

      expect {
        post recipient_gift_ideas_path(recipient), params: {
          gift_idea: {
            title: "Coffee Maker",
            notes: "Fancy espresso machine",
            url: "https://example.com/coffee"
          }
        }
      }.to change(GiftIdea, :count).by(1)

      expect(response).to have_http_status(:found)

      new_gift = GiftIdea.last
      expect(new_gift.title).to eq("Coffee Maker")
      expect(new_gift.notes).to eq("Fancy espresso machine")
      expect(new_gift.url).to eq("https://example.com/coffee")
      expect(new_gift.recipient).to eq(recipient)
    end

    it "handles validation errors" do
      log_in_as(user)

      post recipient_gift_ideas_path(recipient), params: {
        gift_idea: {
          title: "",
          notes: ""
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end