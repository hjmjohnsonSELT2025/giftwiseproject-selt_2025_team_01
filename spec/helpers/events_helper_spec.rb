require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the EventsHelper. For example:
#
# describe EventsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end

RSpec.describe EventsHelper, type: :helper do
  it "formats an event date as YYYY-MM-DD" do
    event = Event.new(date: Date.new(2025, 12, 25))
    expect(helper.formatted_event_date(event)).to eq("2025-12-25")
  end
end