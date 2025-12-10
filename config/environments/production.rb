require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # Ensures master key availability for credentials.
  # config.require_master_key = true

  # Disable serving static files from public/.
  # config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Compress CSS using a preprocessor.
  # config.assets.css_compressor = :sass

  # Do not fallback to asset pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Store uploaded files locally (can change if using cloud storage)
  config.active_storage.service = :local

  # ================================
  # Action Mailer / SendGrid Setup
  # ================================
  #
  # You MUST set these on Heroku:
  #   heroku config:set SENDGRID_USERNAME=apikey
  #   heroku config:set SENDGRID_API_KEY=YOUR_REAL_KEY
  #   heroku config:set APP_HOST=giftwise-10b0e357cd5b.herokuapp.com

  # Links inside emails (password reset, etc.)
  config.action_mailer.default_url_options = {
    host: ENV.fetch("APP_HOST", "giftwise-10b0e357cd5b.herokuapp.com"),
    protocol: "https"
  }

  # Actually send emails in production
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  # Use SendGrid via SMTP
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    user_name: ENV.fetch("SENDGRID_USERNAME", "apikey"),
    password:  ENV.fetch("SENDGRID_API_KEY", ""),
    domain:    ENV.fetch("APP_HOST", "giftwise-10b0e357cd5b.herokuapp.com"),
    address:   "smtp.sendgrid.net",
    port:      587,
    authentication: :plain,
    enable_starttls_auto: true
  }

  # Force all access over SSL
  config.force_ssl = true

  # Log to STDOUT (used by Heroku)
  config.logger = ActiveSupport::Logger.new(STDOUT)
                                       .tap  { |logger| logger.formatter = ::Logger::Formatter.new }
                                       .then { |logger| ActiveSupport::TaggedLogging.new(logger) }

  # Prepend all log lines with request ID.
  config.log_tags = [:request_id]

  # Info-level logs
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Disable Action Mailer caching
  config.action_mailer.perform_caching = false

  # i18n fallback settings
  config.i18n.fallbacks = true

  # Do not log deprecation warnings
  config.active_support.report_deprecations = false

  # Do not dump schema after migrations
  config.active_record.dump_schema_after_migration = false

  # Allowed hosts settings (optional)
  # config.hosts = ["giftwise-10b0e357cd5b.herokuapp.com"]
end
