require 'apartment/elevators/subdomain'

class SubdomainMatcher
  class << self
    def subdomain_excluded?(request)
      excluded_subdomains.include? request.subdomain
    end

    def excluded_subdomains
      Apartment::Elevators::Subdomain.excluded_subdomains
    end
  end
end

class SubdomainPresent < SubdomainMatcher
  def self.matches?(request)
    request.subdomain.present? && !subdomain_excluded?(request)
  end
end

class SubdomainAbsent < SubdomainMatcher
  def self.matches?(request)
    request.subdomain.blank? || subdomain_excluded?(request)
  end
end
