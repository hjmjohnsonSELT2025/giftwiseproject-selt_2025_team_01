require "rails_helper"

RSpec.describe "Framework files load for coverage" do
  it "loads ActionCable base classes" do
    expect(defined?(ApplicationCable::Channel)).to eq("constant")
    expect(defined?(ApplicationCable::Connection)).to eq("constant")
  end

  it "loads ApplicationJob" do
    expect(defined?(ApplicationJob)).to eq("constant")
  end

  it "loads ApplicationMailer" do
    expect(defined?(ApplicationMailer)).to eq("constant")
  end
end
