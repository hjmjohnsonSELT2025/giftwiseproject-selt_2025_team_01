require "rails_helper"

RSpec.describe FormFieldComponent, type: :component do
  let(:recipient) { Recipient.new }
  let(:view) do
    ActionView::Base.new(
      ActionController::Base.view_paths,
      {},
      ActionController::Base.new
    )
  end
  let(:form) { ActionView::Helpers::FormBuilder.new(:recipient, recipient, view, {}) }

  it "renders text field" do
    rendered = render_inline(
      described_class.new(form: form, field: :name, label: "Name", type: :text_field, options: {})
    )

    expect(rendered.to_html).to include("Name")
  end
end
