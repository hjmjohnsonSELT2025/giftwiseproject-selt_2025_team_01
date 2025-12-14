require "rails_helper"

RSpec.describe ApplicationMailer, type: :mailer do
  it "inherits from ActionMailer::Base" do
    expect(described_class < ActionMailer::Base).to be(true)
  end
end
