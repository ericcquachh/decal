source 'https://rubygems.org'
 
ruby '1.9.3'
gem 'rails', '3.2.16'

group :development, :test do
  gem 'sqlite3'
  gem 'ruby-debug19'
  gem 'database_cleaner'
  gem 'cucumber-rails', :require => false

  gem 'rspec-rails', '~> 2.14.0'
  gem 'simplecov', :require => false, :group => :test
  'rake'
end


group :production do
  gem 'pg'
end

group :assets do
  gem 'uglifier'

  gem 'therubyracer'
  gem 'sass-rails'
  #gem 'coffee-rails'

    #bootstrap (installed without gem)
  #gem 'bootstrap-sass', '~> 3.2.0'
  #gem 'autoprefixer-rails'

end

gem 'jquery-rails'
gem 'haml'
