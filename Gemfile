source "https://rubygems.org"

ruby "2.4.2"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 5.1.4"
# Use postgresql as the database for Active Record
gem "pg", "~> 0.18"
# Use Puma as the app server
gem "puma", "~> 3.7"

gem "webpacker", "~> 3.0"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Authentication and Authorization
gem "devise", "~> 4.3"
gem "devise-i18n", "~> 1.5"

# Route/Controller/View DRYers
gem "decent_exposure", "~> 3.0"

group :development, :test do
  # Debugging
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "pry"

  # Test runners and supporting utilities
  gem "factory_bot_rails", "~> 4.8"
  gem "rspec-rails", "~> 3.6"

  # Feature testing
  gem "capybara", "~> 2.16"
  gem "capybara-screenshot"
  gem "cucumber-rails", "~> 1.5", require: false
  gem "database_cleaner"
  gem "selenium-webdriver", "~> 3.8"
  gem "site_prism", "~> 2.9"

  # Dev tooling niceties
  gem "coveralls", require: false
end

group :assets do
  gem "uglifier", "~> 4.0"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem "web-console", ">= 3.3.0"

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"

  # Checks that code matches our style guide
  gem "rubocop", "~> 0.52"
  gem "rubocop-migrations", "~> 0.1"
  gem "rubocop-rspec", "~> 1.20.1"

  # Runs pre-commit and pre-push checks
  gem "overcommit", "~> 0.41"

  # Document ALL THE THINGS!
  gem "yard"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
