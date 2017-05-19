FactoryGirl.define do

  factory :account do
    email Faker::Internet.email
    subdomain Faker::StarWars.planet.underscore.gsub(' ','_')
  end

end
