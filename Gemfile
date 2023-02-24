source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.0"
gem "puma", "~> 6.1.0"
gem 'bcrypt', '~> 3.1'
gem 'jwt', '~> 2.7'
gem 'redis', '~> 5.0'
gem 'active_interaction', '~> 5.2'
gem 'active_model_serializers', '~> 0.10.13'
gem 'bootsnap', '~> 1.16.0'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'pry', '~> 0.13.1'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'factory_bot_rails'
  gem 'faker'
end
