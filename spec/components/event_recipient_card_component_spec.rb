require "rails_helper"

RSpec.describe EventRecipientCardComponent, type: :component do
  let(:user) { create(:user) }
  let(:event) { create(:event, user: user) }
  let(:recipient) { create(:recipient, user: user, name: "Bob") }

  let(:event_recipient) do
    EventRecipient.create!(event: event, recipient: recipient)
  end

  it "renders recipient name" do
    allow_any_instance_of(EventRecipientCardComponent)
      .to receive(:new_event_recipient_gift_idea_path)
            .and_return("/new")

    rendered = render_inline(
      described_class.new(
        event: event,
        recipient: recipient,
        event_recipient: event_recipient,
        action: :add
      )
    )

    expect(rendered.to_html).to include("Bob")
    expect(rendered.to_html).to include("Add")
  end
end
