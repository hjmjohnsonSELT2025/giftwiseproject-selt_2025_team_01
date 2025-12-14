# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("DEFAULT_FROM_EMAIL", "teamonegiftwisenotif@gmail.com")
  layout "mailer"
end
