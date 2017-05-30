require 'apartment/elevators/subdomain'

module DomainGenerator
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
      request.subdomain.present?
    end

    def self.private?(request)
      self.matches?(request) && !subdomain_excluded?(request)
    end
  end

  class SubdomainAbsent < SubdomainMatcher
    def self.matches?(request)
      request.subdomain.blank?
    end

    def self.private?(request)
      self.matches?(request) || subdomain_excluded?(request)
    end
  end
end
