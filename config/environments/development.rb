Suwaru::Application.configure do
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

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  
  # Reload classes on every request
  config.dependency_loading = true
  
  # Don't care if the mailer can't send
  config.action_mailer.default_url_options = { :host => '127.0.0.1:3000' }
  
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_content_type = 'text/html' 
  config.action_mailer.smtp_settings = {
     :enable_tls_auto => true,
     :tls => true,
     :address => "smtp.gmail.com",
     :port => 587,
     :domain => "suwaru.net",
     :authentication => :plain,
     :user_name => "dev.suwaru@gmail.com",
     :password => "M@nnB@ch?!",
  }
  
  # Global Variables
  INSTALLER_DIR       = File.expand_path(File.join(__FILE__, "../", "../../lib/install/"))
  INSTALLER_DATA_DIR  = File.expand_path(File.join(__FILE__, "../", "../../lib/install/data/"))
  INSTALLER_TYPES_DIR = File.expand_path(File.join(__FILE__, "../", "../../lib/install/types/"))
  
  DECL_AUTH_HOME      = File.expand_path(File.join(__FILE__, "../", "../../vendor/bundle/ruby/1.8/gems/declarative_authorization-0.5.5"))
end

