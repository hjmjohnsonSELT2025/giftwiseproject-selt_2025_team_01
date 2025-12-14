require "rails_helper"

RSpec.describe RecipientCardComponent, type: :component do
  let(:recipient) { create(:recipient, name: "Alice") }

  it "renders recipient name" do
    allow_any_instance_of(RecipientCardComponent)
      .to receive(:recipient_path)
            .and_return("/recipients/1")

    rendered = render_inline(described_class.new(recipient: recipient, index: 0))

    expect(rendered.to_html).to include("Alice")
  end
end
