require "rails_helper"

RSpec.describe EventsController, type: :controller do
  def create_user!
    attrs = {}
    attrs[:email] = "spec_user_#{SecureRandom.hex(4)}@example.com" if User.column_names.include?("email")

    if User.column_names.include?("password_digest")
      attrs[:password] = "password123!"
      attrs[:password_confirmation] = "password123!"
    end

    user = User.new(attrs)
    user.save!(validate: false)
    user
  end

  let(:user) { create_user! }

  before do
    # Make require_login pass (most apps check session[:user_id])
    session[:user_id] = user.id

    # If your current_user helper reads from session, you can skip this.
    # If it doesn't, leaving this here ensures current_user is non-nil.
    allow(controller).to receive(:current_user).and_return(user)
  end

  it "redirects to index with alert when event is not found" do
    get :show, params: { id: -1 }
    expect(response).to redirect_to(events_path)
    expect(flash[:alert]).to eq("Event not found")
  end
end
