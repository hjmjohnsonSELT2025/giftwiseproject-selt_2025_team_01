require "rails_helper"

RSpec.describe ApplicationCable::Channel, type: :channel do
  it "can be inherited by a channel" do
    expect(Class.new(ApplicationCable::Channel) < ApplicationCable::Channel).to be true
  end
end
