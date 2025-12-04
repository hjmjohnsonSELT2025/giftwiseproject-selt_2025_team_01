require "rails_helper"

RSpec.describe "Event Recipient Management", type: :request do
  let!(:user) { User.create!(email: "user@example.com", password: "pass123", password_confirmation: "pass123") }
  let!(:other_user) { User.create!(email: "other@example.com", password: "pass123", password_confirmation: "pass123") }
  let!(:recipient1) { user.recipients.create!(name: "Alice") }
  let!(:recipient2) { user.recipients.create!(name: "Bob") }
  let!(:event)      { user.events.create!(name: "Birthday Party", date: Date.today) }
  let!(:other_event){ other_user.events.create!(name: "Other Event", date: Date.today) }

  before do
    post login_path, params: { email: user.email, password: "pass123" }
  end

  describe "POST /events/:id/add_recipient" do
    it "adds a recipient to the event" do
      post add_recipient_event_path(event), params: { recipient_id: recipient1.id }

      expect(response).to redirect_to(event_path(event))
      follow_redirect!
      expect(response.body).to include("Recipient added")
      expect(event.reload.recipients).to include(recipient1)
    end

    it "returns 404 for another user's event" do
      post add_recipient_event_path(other_event), params: { recipient_id: recipient1.id }

      expect(response).to have_http_status(:not_found)
      expect(other_event.reload.recipients).not_to include(recipient1)
    end

    it "does not duplicate recipients" do
      event.recipients << recipient1

      post add_recipient_event_path(event), params: { recipient_id: recipient1.id }

      count = event.reload.recipients.where(id: recipient1.id).count
      expect(count).to eq(1)
    end
  end

  describe "DELETE /events/:id/remove_recipient" do
    before { event.recipients << recipient1 }

    it "removes a recipient from the event" do
      delete remove_recipient_event_path(event), params: { recipient_id: recipient1.id }

      expect(response).to redirect_to(event_path(event))
      follow_redirect!
      expect(response.body).to include("Recipient removed")
      expect(event.reload.recipients).not_to include(recipient1)
    end

    it "returns 404 when removing from another user's event" do
      delete remove_recipient_event_path(other_event), params: { recipient_id: recipient1.id }

      expect(response).to have_http_status(:not_found)
      expect(other_event.reload.recipients).not_to include(recipient1)
    end
  end
end
