require "rails_helper"

RSpec.describe EventDetailsComponent, type: :component do
  let(:user) { create(:user) }
  let(:event) { create(:event, user: user, budget: 100) }

  it "renders event details" do
    rendered = render_inline(described_class.new(event: event))

    expect(rendered.to_html).to include("Event Details")
    expect(rendered.to_html).to include("$100")
  end
end
