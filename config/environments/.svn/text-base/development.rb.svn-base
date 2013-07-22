require 'lib/interceptors/development_mail_interceptor'
require 'lib/modules/properties_helper'

AnalyticsPortal::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # used by mailers and devise
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  ActionMailer::Base.default :from => 'analytics@smithmicro.com'

  # needed for the subclasses method to load child models in single table inheritance
  config.to_prepare {
    Dir.glob(File.join(Rails.root, 'app', 'models', '*{report.rb,filter_param.rb}')).each do |file|
      require_dependency file
    end
  }
end

ActionMailer::Base.smtp_settings = {
  :address              => "207.67.226.5",
  :port                 => 25,
  :domain               => "smithmicro.com",
#  :user_name            => "analytics@smithmicro.com",
#  :password             => "",
#  :authentication       => "plain",
  :enable_starttls_auto => false
}

Mail.register_interceptor(DevelopmentMailInterceptor)