require "rails_helper"

RSpec.describe "Load framework files for coverage" do
  it "loads ActionCable channel/connection base files" do
    require Rails.root.join("app/channels/application_cable/channel.rb")
    require Rails.root.join("app/channels/application_cable/connection.rb")

    expect(defined?(ApplicationCable::Channel)).to eq("constant")
    expect(defined?(ApplicationCable::Connection)).to eq("constant")
  end

  it "loads ApplicationJob" do
    require Rails.root.join("app/jobs/application_job.rb")
    expect(defined?(ApplicationJob)).to eq("constant")
  end

  it "loads ApplicationMailer" do
    require Rails.root.join("app/mailers/application_mailer.rb")
    expect(defined?(ApplicationMailer)).to eq("constant")
  end
end
