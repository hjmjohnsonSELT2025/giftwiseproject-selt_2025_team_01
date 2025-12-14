require "rails_helper"

RSpec.describe GiftIdeaCardComponent, type: :component do
  let(:gift_idea) do
    GiftIdea.new(
      title: "Cool Gift",
      notes: "Very thoughtful",
      url: "https://example.com"
    )
  end

  before do
    allow_any_instance_of(GiftIdeaCardComponent).to receive(:edit_path).and_return("/fake/edit/path")
    allow_any_instance_of(GiftIdeaCardComponent).to receive(:delete_path).and_return("/fake/delete/path")
  end

  it "renders title and notes" do
    rendered = render_inline(described_class.new(gift_idea: gift_idea))

    expect(rendered.to_html).to include("Cool Gift")
    expect(rendered.to_html).to include("Very thoughtful")
  end
end
