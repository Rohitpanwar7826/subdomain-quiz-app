require_relative "boot"
require "rails/all"
require 'apartment/elevators/subdomain'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module QuizApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.active_job.queue_adapter = :sidekiq
    # Configuration for the application, engines, and railties goes here.
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
    config.middleware.use Apartment::Elevators::Subdomain
    config.hosts << Rails.application.credentials.tenant_whitelist_subdomain
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # config/environments/development.rb
    config.time_zone = "UTC"

    # config/environments/production.rb
    config.time_zone = "Asia/Kolkata"
  end
end
