class ApplicationMailer < ActionMailer::Base
  # This MUST be a single-line string with no hidden newlines.
  # Use the exact email address you verified in SendGrid.
  default from: "teamonegiftwisenotif@gmail.com"

  layout "mailer"
end
