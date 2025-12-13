require 'rails_helper'

RSpec.describe "Events", type: :request do
  let(:user) do
    User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  let(:other_user) do
    User.create!(
      email: "other@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  #def log_in_as(u)
  #  post login_path, params: { email: u.email, password: "password123" }
  #  # same pattern as your Users request spec
  #  session[:user_id] = u.id
  #end

  describe "GET /events" do
    it "redirects to login when not logged in" do
      get events_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it "shows only the logged-in user's events" do
      my_event = Event.create!(
        user: user,
        name: "My Birthday",
        date: Date.new(2025, 12, 25)
      )
      other_event = Event.create!(
        user: other_user,
        name: "Other Event",
        date: Date.new(2025, 1, 1)
      )

      #log_in_as(user)
      sign_in(user)
      get events_path

      expect(response).to have_http_status(:success)
      expect(response.body).to include("My Birthday")
      expect(response.body).to include(my_event.date.to_s)

      expect(response.body).not_to include("Other Event")
    end
  end

  describe "POST /events" do
    before { sign_in(user) }

    it "creates an event with valid attributes and redirects to index" do
      expect {
        post events_path, params: {
          event: {
            name: "New Event",
            date: "2025-12-31",
            description: "NYE Party",
            theme: "Gold",
            budget: 200
          }
        }
      }.to change(Event, :count).by(1)

      expect(response).to redirect_to(events_path)
      follow_redirect!
      expect(response.body).to include("Event created!")
      expect(response.body).to include("New Event")
    end

    it "does not create an event with invalid attributes and re-renders new" do
      expect {
        post events_path, params: {
          event: {
            name: "",
            date: "",
            theme: "No date"
          }
        }
      }.not_to change(Event, :count)

      expect(response).to have_http_status(:ok) # render :new
      expect(response.body).to include("error") # from error_explanation in the form
    end
  end

  describe "PATCH /events/:id" do
    let!(:event) do
      Event.create!(
        user: user,
        name: "Original Name",
        date: Date.new(2025, 1, 1),
        theme: "Red"
      )
    end

    context "when logged in as the owner" do
      before { sign_in(user) }

      it "updates the event with valid data and redirects to index" do
        patch event_path(event), params: {
          event: {
            name: "Updated Name",
            theme: "Blue"
          }
        }

        expect(response).to redirect_to(events_path)
        follow_redirect!

        event.reload
        expect(event.name).to eq("Updated Name")
        expect(event.theme).to eq("Blue")
        expect(response.body).to include("Event updated!")
        expect(response.body).to include("Updated Name")
      end

      it "does not update the event with invalid data and re-renders edit" do
        patch event_path(event), params: {
          event: {
            name: ""
          }
        }

        expect(response).to have_http_status(:ok) # render :edit
        event.reload
        expect(event.name).to eq("Original Name")
        expect(response.body).to include("error")
      end
    end

    context "when logged in as a different user" do
      before { sign_in(other_user) }

      it "does not allow editing and redirects with alert" do
        patch event_path(event), params: {
          event: { name: "Hacker Edit" }
        }

        expect(response).to redirect_to(events_path)
        follow_redirect!
        expect(response.body).to include("Event not found")

        event.reload
        expect(event.name).to eq("Original Name")
      end
    end
  end

  describe "DELETE /events/:id" do
    let!(:event) do
      Event.create!(
        user: user,
        name: "Delete Me",
        date: Date.new(2025, 6, 15)
      )
    end

    context "when logged in as the owner" do
      before { sign_in(user) }

      it "deletes the event and redirects to index" do
        expect {
          delete event_path(event)
        }.to change(Event, :count).by(-1)

        expect(response).to redirect_to(events_path)
        follow_redirect!
        expect(response.body).to include("Event deleted")
        expect(response.body).not_to include("Delete Me")
      end
    end

    context "when logged in as another user" do
      before { sign_in(other_user) }

      it "does not delete the event and redirects with alert" do
        expect {
          delete event_path(event)
        }.not_to change(Event, :count)

        expect(response).to redirect_to(events_path)
        follow_redirect!
        expect(response.body).to include("Event not found")
      end
    end
  end
end
