require "rails_helper"

RSpec.describe AvailableRecipientsComponent, type: :component do
  let(:user) { create(:user) }
  let(:event) { create(:event, user: user) }
  let(:recipients) { create_list(:recipient, 2) }

  it "renders recipient list" do
    allow_any_instance_of(AvailableRecipientsComponent)
      .to receive(:add_recipient_event_path)
            .and_return("/add")

    rendered = render_inline(
      described_class.new(event: event, recipients: recipients)
    )

    recipients.each do |recipient|
      expect(rendered.to_html).to include(recipient.name)
    end
  end
end
