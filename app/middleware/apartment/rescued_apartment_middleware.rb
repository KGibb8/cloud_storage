module RescuedApartmentMiddleware
  def call(env)
    begin
      super
    rescue ::Apartment::TenantNotFound
      path = env['HTTP_HOST'].split(':').first
      missing_subdomain = path.match(/(\w+).#{ENV['APP_DOMAIN']}$/)[1] rescue Apartment::Tenant.current
      msg = "ERROR: Apartment Tenant not found: #{missing_subdomain}"
      Rails.logger.error msg
      raise NotFound.new, msg rescue not_found
    end
  end

  def not_found
    return [404, {"Content-Type" => "text/html"}, ["#{File.read(Rails.root.to_s + '/public/404.html')}"] ]
  end
end
