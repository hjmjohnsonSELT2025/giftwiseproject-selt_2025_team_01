require "rails_helper"

RSpec.describe EventCardComponent, type: :component do
  let(:user) { create(:user) }
  let(:event) { create(:event, user: user, name: "Party") }

  it "renders event name" do
    allow_any_instance_of(EventCardComponent)
      .to receive(:event_path)
            .and_return("/events/1")

    rendered = render_inline(described_class.new(event: event))

    expect(rendered.to_html).to include("Party")
  end
end
