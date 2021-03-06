source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'apartment'
gem 'awesome_print'
gem 'devise'
gem 'devise_invitable'
gem 'dotenv'
gem 'font-awesome-rails'
gem 'hamburgers'
gem 'haml-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'materialize-sass'
gem 'paperclip'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.2'
gem 'redis', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'sidekiq'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'pry-byebug', platform: :mri
end


group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'dotenv-rails'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'rspec-sidekiq'
  gem 'simplecov'
  gem 'faker'
  gem 'capybara'
  gem 'rails-controller-testing'
  gem 'database_cleaner'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
