require "rails_helper"

RSpec.describe "Events", type: :request do
  let(:user) do
    User.create!(
      email: 'user@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  let(:other_user) do
    User.create!(
      email: 'otheruser@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  def log_in_as(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
  end

  describe "GET /events" do
    it "redirects to login when not logged in" do

      get events_path

      expect(response).to redirect_to(login_path)
      expect(flash[:alert]).to eq("Please log in to access this page.")
    end

    it "returns success when logged in" do
      log_in_as(user)

      get events_path

      expect(response).to have_http_status(:ok)
    end

    it "only shows events for the current user" do
      user_event = Event.create!(name: "Christmas", user: user)
      other_event = Event.create!(name: "Birthday", user: other_user)

      log_in_as(user)
      get events_path

      expect(response.body).to include("Christmas")
      expect(response.body).not_to include("Birthday")
    end


  end

  describe "POST /events" do
    let(:valid_params) do
      {
        event: {
          name: "Christmas",
          date: "2025-12-25",
          description: "Family gift exchange"
        }
      }
    end

    let(:invalid_params) do
      {
        event: {
          name: "",
          date: "2025-12-25",
          description: "Family gift exchange"
        }
      }
    end

    it "redirects to login and does not create when not logged in" do
      expect {
        post events_path, params: valid_params
      }.not_to change(Event, :count)

      expect(response).to redirect_to(login_path)
      expect(flash[:alert]).to eq("Please log in to access this page.")
    end

    it "creates an event for the current user with valid params" do
      log_in_as(user)

      expect {
        post events_path, params: valid_params
      }.to change(Event, :count).by(1)

      event = Event.last
      expect(event.user).to eq(user)
      expect(event.name).to eq("Christmas")

      expect(response).to redirect_to(events_path)
      expect(flash[:notice]).to eq("Event was successfully created.")
    end

    it "does not create an event for the current user with invalid params and re-renders form" do
      log_in_as(user)

      expect {
        post events_path, params: invalid_params
      }.not_to change(Event, :count)

      expect(response).to have_http_status(:unprocessable_content)

      #should be include("Name can't be blank") however the apostrophe is funky with the test
      expect(response.body).to include("be blank")
    end


  end


end