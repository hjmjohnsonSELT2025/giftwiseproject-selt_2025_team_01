require 'rails_helper'

RSpec.describe "EventRecipientGiftIdeas", type: :request do
  let(:user) do
    User.create!(
      email: "user@example.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  let(:event) do
    Event.create!(
      name: "Birthday Party",
      user: user,
      date: Date.today
    )
  end

  let(:recipient) do
    Recipient.create!(
      name: "Mom",
      user: user
    )
  end

  let!(:event_recipient) do
    EventRecipient.create!(event: event, recipient: recipient)
  end

  def log_in_as(u)
    post login_path, params: {
      email: u.email,
      password: "password"
    }
  end



  describe "GET /events/:event_id/recipients/:recipient_id/gift_ideas" do
    it "redirects to login when not logged in" do
      get event_recipient_gift_ideas_path(event, recipient)
      expect(response).to redirect_to(login_path)
    end

    it "returns success when logged in" do
      log_in_as(user)
      get event_recipient_gift_ideas_path(event, recipient)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Mom")
    end
  end



  describe "POST /events/:event_id/recipients/:recipient_id/gift_ideas" do
    it "redirects to login when not logged in" do
      post event_recipient_gift_ideas_path(event, recipient), params: { event_recipient_gift_idea: { title: "New Gift" } }
      expect(response).to redirect_to(login_path)
    end

    it "creates a new gift idea when logged in" do
      log_in_as(user)

      expect {
        post event_recipient_gift_ideas_path(event, recipient), params: {
          event_recipient_gift_idea: {
          title: "Coffee Maker",
            notes: "Fancy espresso machine",
            url: "https://example.com/coffee"
          }
        }
      }.to change(EventRecipientGiftIdea, :count).by(1)

      new_gift = EventRecipientGiftIdea.last
      expect(new_gift.title).to eq("Coffee Maker")
      expect(new_gift.notes).to eq("Fancy espresso machine")
      expect(new_gift.url).to eq("https://example.com/coffee")
      expect(new_gift.event_recipient).to eq(event_recipient)
    end

    it "handles validation errors" do
      log_in_as(user)
      post event_recipient_gift_ideas_path(event, recipient), params: { event_recipient_gift_idea: { title: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end



  describe "DELETE /events/:event_id/recipients/:recipient_id/gift_ideas/:id" do
    let!(:gift) do
      EventRecipientGiftIdea.create!(
        title: "Spa Package",
        notes: "Relaxing spa day",
        url: "https://example.com/spa",
        event_recipient: event_recipient
      )
    end

    it "redirects to login when not logged in" do
      delete event_recipient_gift_idea_path(event, recipient, gift)
      expect(response).to redirect_to(login_path)
    end

    it "deletes the gift idea when logged in" do
      log_in_as(user)
      expect {
        delete event_recipient_gift_idea_path(event, recipient, gift)
      }.to change(EventRecipientGiftIdea, :count).by(-1)
      expect(response).to redirect_to(event_recipient_gift_ideas_path(event, recipient))
    end
  end



  describe "PATCH /events/:event_id/recipients/:recipient_id/gift_ideas/:id" do
    let!(:gift) do
      EventRecipientGiftIdea.create!(
        title: "Spa Package",
        notes: "Relaxing spa day",
        url: "https://example.com/spa",
        event_recipient: event_recipient
      )
    end

    it "updates the gift idea when logged in" do
      log_in_as(user)
      patch event_recipient_gift_idea_path(event, recipient, gift), params: {
        event_recipient_gift_idea: { title: "Updated Spa Package" }
      }
      gift.reload
      expect(gift.title).to eq("Updated Spa Package")
    end
  end
end