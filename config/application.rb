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

Dir['./app/lib/**/*.rb'].each { |file| require file }

Bundler.require(*Rails.groups)

module CloudStorage
  class Application < Rails::Application
    config.middleware.use Apartment::Elevators::Subdomain
    config.middleware.use DomainGenerator::CustomDomainCookie, ".#{ENV.fetch( 'APP_DOMAIN' )}"
  end
end
