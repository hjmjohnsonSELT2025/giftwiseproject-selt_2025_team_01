require "rails_helper"

RSpec.describe ApplicationCable::Connection, type: :channel do
  it "connects successfully" do
    connect "/cable"
    expect(connection).to be_instance_of(ApplicationCable::Connection)
  end
end
