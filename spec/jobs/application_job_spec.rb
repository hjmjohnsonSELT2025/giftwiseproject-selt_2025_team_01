require "rails_helper"

RSpec.describe ApplicationJob, type: :job do
  it "inherits from ActiveJob::Base" do
    expect(described_class < ActiveJob::Base).to be(true)
  end
end
