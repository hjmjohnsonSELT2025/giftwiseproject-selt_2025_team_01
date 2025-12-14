require "rails_helper"

RSpec.describe SectionHeaderComponent, type: :component do
  it "renders header text" do
    rendered = render_inline(described_class.new(title: "Header", subtitle: "Subheader"))

    expect(rendered.to_html).to include("Header")
    expect(rendered.to_html).to include("Subheader")
  end
end
