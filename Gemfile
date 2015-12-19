#source 'https://rubygems.org'
source 'https://ruby.taobao.org'
gem 'rails', '3.2.16'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'bcrypt-ruby', '3.0.1'
gem 'bootstrap-sass', '2.3.2.0'
gem 'turbolinks'

gem 'gravatar_image_tag'
gem 'devise'
#gem 'tlsmail' # seems not supported in Rails3

group :development, :test do
	gem 'rspec-rails', '2.13.1'
end

group :test do
	gem 'capybara', '1.1.2'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'


gem 'carrierwave', '0.10.0'		#用于图片处理的gem
gem 'mini_magick'

gem 'ajaxful_rating', '>= 3.0.0.beta8'
gem 'webrick'


group :development, :test do
	gem 'sqlite3'
end

group :production do
	gem 'pg'
	#gem 'thin'		#push到heroku时需要取消注释
end

gem 'heroku'


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
