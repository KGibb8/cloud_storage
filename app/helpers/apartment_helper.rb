module ApartmentHelper
  def switch_tenant!(subdomain = 'public')
    Apartment::Tenant.switch!(subdomain)
  end
end
