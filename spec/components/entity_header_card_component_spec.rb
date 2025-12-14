require "rails_helper"

RSpec.describe EntityHeaderCardComponent, type: :component do
  let(:user) { create(:user) }
  let(:entity) { create(:event, user: user, name: "My Event") }

  it "renders entity name and back link" do
    rendered = render_inline(
      described_class.new(
        entity: entity,
        back_path: "/back",
        tags: [],
        edit_path: nil,
        delete_path: nil
      )
    )

    expect(rendered.to_html).to include("My Event")
    expect(rendered.to_html).to include("Back")
  end
end
