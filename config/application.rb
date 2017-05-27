require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require 'apartment/elevators/subdomain'

Bundler.require(*Rails.groups)

module CloudStorage
  class Application < Rails::Application
    config.middleware.use Apartment::Elevators::Subdomain
    config.autoload_paths += %W(#{Rails.root}/app/middleware #{Rails.root}/app/lib)
  end
end
