class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def switch_tenant!(subdomain)
    Apartment::Tenant.switch!(subdomain)
  end

end
