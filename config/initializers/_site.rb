
site_config = File.read Rails.root.join('config', 'site.yml')

site_config = ActiveSupport::HashWithIndifferentAccess.new( Psych.load(site_config) )[Rails.env]

Site = OpenStruct.new(site_config)

Site.domain = ( ENV['APP_DOMAIN'] || Site.domain) if Rails.env.development?

Site.host, Site.port = Site.domain.split(':')
