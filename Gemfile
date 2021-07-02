source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'rails', '~> 6.1.4'
gem 'pg', '~> 1.1'
gem 'jbuilder', '~> 2.7'
# gem 'redis', '~> 4.0'
gem 'bcrypt', '~> 3.1.7'
gem 'image_processing', '~> 1.2'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'rack-cors'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'

  gem 'capistrano', '~> 3.16', require: false
  gem 'capistrano-rails', '~> 1.6', require: false
  gem 'capistrano-bundler', '~> 2.0'
  gem 'capistrano-passenger'
  gem 'capistrano-rvm'
  gem 'ed25519'
  gem 'bcrypt_pbkdf'
end

gem 'passenger'
gem 'jwt'