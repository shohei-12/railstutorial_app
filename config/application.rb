require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailstutorialApp
  class Application < Rails::Application # Change to slim
    config.generators.template_engine = :slim # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Embed an authentication token in a remote form
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
