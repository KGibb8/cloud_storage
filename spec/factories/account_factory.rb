FactoryGirl.define do

  factory :account do
    email Faker::Internet.email
    subdomain Faker::Internet.domain_word
  end

end
