require 'rails_helper'

describe DomainGenerator do

  before(:all) { Request = Struct.new(:subdomain) }

  let(:request) { ->(subdomain) { Request.new(subdomain) } }

  describe DomainGenerator::SubdomainMatcher do
    let(:super_matcher) { DomainGenerator::SubdomainMatcher }

    it 'lists excluded apartment domains' do
      expect(super_matcher.excluded_subdomains).to include 'app'
    end

    it 'returns true or false if subdomain is reserved' do
      expect(super_matcher.subdomain_excluded?(request['app'])).to be_truthy
      expect(super_matcher.subdomain_excluded?(request['pirates'])).to be_falsey
    end
  end

  describe DomainGenerator::SubdomainPresent do
    let(:matcher) { DomainGenerator::SubdomainPresent }

    it 'returns true if valid subdomain' do
      expect(matcher.private?(request['pirates'])).to be_truthy
    end

    it 'returns false if invalid subdomain' do
      expect(matcher.private?(request['app'])).to be_falsey
    end
  end

  describe DomainGenerator::SubdomainAbsent do
    let(:matcher) { DomainGenerator::SubdomainAbsent }

    it 'returns true if invalid subdomain' do
      expect(matcher.private?(request['app'])).to be_truthy
    end

    it 'returns false if valid subdomain' do
      expect(matcher.private?(request['monkeys'])).to be_falsey
    end
  end

end
