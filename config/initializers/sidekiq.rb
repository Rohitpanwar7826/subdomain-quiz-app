require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { :url => "redis://localhost:6379", db: 2 }
end

Sidekiq.configure_server do |config|
  config.redis = { :url => "redis://localhost:6379", db: 2 }
end