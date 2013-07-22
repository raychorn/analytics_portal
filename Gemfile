source 'http://rubygems.org'

gem 'rails', '3.0.7'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'sqlite3-ruby', :require => 'sqlite3'
if (ENV['OS'].nil? == false) and (ENV['OS'].downcase.index('windows') >= 0)
	gem 'mysql'
else
	gem 'mysql2', '< 0.3'
end

# Use unicorn as the web server
# gem 'unicorn'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# TODO: freeze gems before last full testing cycle by QE
gem 'jquery-rails', '0.2.7'
gem 'devise', '1.3.3'
gem 'devise_invitable', '0.4.2'
gem 'cancan', '1.6.4'
gem 'will_paginate', '3.0.pre2'
gem 'simple_form', '1.3.1'
gem 'tabs_on_rails', '>= 2.0.1'
gem 'acts_as_singleton', '0.0.5'
gem 'acts-as-taggable-on', '2.0.6'
gem 'resque', '1.15.0'
if (ENV['OS'].nil? == false) and (ENV['OS'].downcase.index('windows') >= 0)
	gem 'ghazel-SystemTimer', '1.2.1.1'
else
	gem 'SystemTimer', '1.2.1'
end
gem 'cocoon', '1.0.3'
gem 'siren', '0.2.0'
gem 'acts_as_list', '0.1.2'
gem 'yaml_db', '0.2.1'
gem 'clockwork', '0.2.3'
gem 'delayed_job', '2.1.4'
gem 'properties-ruby', '0.0.4'

# TODO: move compass gem to development after looking into initialization on production
gem 'compass', '>= 0.10.6'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'capistrano'
  gem 'rails-footnotes', '>= 3.7'
  # gem 'webrat'
end
