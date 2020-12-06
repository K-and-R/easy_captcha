# frozen_string_literal: true

require 'pry'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'simplecov'
# SimpleCov.minimum_coverage 90
SimpleCov.start 'rails' do
  # Ignore initilalizer template
  add_filter 'lib/generators/templates/'
  # Ignore version file because it already loaded and won't be detected by SimpleCov
  add_filter 'lib/easy_captcha/version'
end

# require 'rails/all'
require 'active_support/all'
require 'action_controller'
require 'action_dispatch'
require 'action_view'
require 'rspec/rails'
require 'easy_captcha'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }
