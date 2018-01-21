source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.7.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.0.5'                    ## manuell
gem 'jquery-turbolinks'                ## manuell


gem 'codemirror-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~> 2.5.3'                      ## manuell
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'bootstrap-sass', '~> 3.2.0.0'                ## manuell
gem 'bootstrap_form', '~> 2.3.0'                  ## manuell
#gem 'data-confirm-modal', github: 'ifad/data-confirm-modal'
gem 'twitter-bootstrap-rails-confirm', '~> 1.0.4' ## manuell
gem 'faker', '~> 1.6.1'                           ## manuell
gem 'd3-rails', '~> 3.5.11'                       ## manuell
gem 'easy_as_pie', '~> 0.1.2'                     ## manuell
gem 'chartkick', '~> 1.4.1'                       ## manuell
gem 'groupdate', '~> 2.1.1'
gem 'active_median', '~> 0.1.0'

gem 'devise', '~> 3.5.3'                          ## manuell

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'obfuscate_id', '~> 0.2.0'                    ## manuell

gem 'carrierwave', '~> 0.10.0'                    ## manuell

gem 'resque', :require => "resque/server"

gem "six"

gem 'redcarpet', '~> 3.0.0'
gem 'pg'
gem 'rmagick'

gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.37'
gem 'bootstrap_form-datetimepicker'


gem 'will_paginate', '~> 3.1.0'

# Use Unicorn as the app server
gem 'unicorn'
gem 'file_validators'
gem 'ratyrate'
gem 'nprogress-rails'
# gem 'pygments.rb'
gem 'highlight', :require => 'simplabs/highlight'
gem 'chart-js-rails'
# Use Capistrano for deployment
group :development do
  gem "capistrano-resque", "~> 0.2.2", require: false
  gem 'capistrano', '>= 3.2.1'
  gem 'capistrano-rbenv', '~> 2.0'           # idiomatic rbenv support
  gem 'capistrano-rbenv-install'             # ensures the right ruby version is installed
  gem 'capistrano-bundler', '~> 1.1.2'       # support for bundler
  gem 'capistrano-rails', '~> 1.0'           # automatic migrations and asset compilation
  gem 'capistrano-unicorn-nginx', '~> 2.0'   # plug-n-play nginx and unicorn
  gem 'capistrano-postgresql', '~> 3.0'      # plug-n-play postgresql
  gem 'capistrano-safe-deploy-to', '~> 1.1'  # ensures deploy path for the app exists
  gem 'capistrano-ssh-doctor'                # helps with debugging ssh-agent forwarding
end

group :development, :test, :staging do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem "letter_opener"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end


group :development, :test do
  gem "rspec-rails", ">= 2.0.1"
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
end
