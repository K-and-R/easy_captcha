# frozen_string_literal: true

# Require specified version of bundler
bundler_version = File.read(
  File.expand_path('.bundler-version', __dir__),
  mode: 'rb'
).chomp
if Gem::Version.new(Bundler::VERSION) != Gem::Version.new(bundler_version)
  abort "Bundler version `#{bundler_version}` is required; "\
    "Bundler version `#{Bundler::VERSION}` used"
end

# Determine from where we get our gems
if File.exist?(File.expand_path('.rubygems-proxy-url', __dir__))
  rubygems_url = File.read(
    File.expand_path('.rubygems-proxy-url', __dir__),
    mode: 'rb'
  ).chomp
end
# rubocop:disable Style/IfUnlessModifier
if rubygems_url.nil? || rubygems_url.empty?
  rubygems_url = 'https://rubygems.org'
end
# rubocop:enable Style/IfUnlessModifier
source rubygems_url

# Normalize repo path
def github_repo_path(repo_name)
  repo_name.include?('/') ? repo_name : "#{repo_name}/#{repo_name}"
end
# Add source for GitHub
git_source(:github) do |repo_name|
  "https://github.com/#{github_repo_path(repo_name)}.git"
end
# Add SSH source for GitHub private repos, mostly
git_source(:github_ssh) do |repo_name|
  "git@github.com:#{github_repo_path(repo_name)}.git"
end

# Determine Ruby version from `.ruby-version` file
ruby File.read(
  File.expand_path('.ruby-version', __dir__),
  mode: 'rb'
).chomp

# load requirements from the `*.gemspec` file
gemspec

# These are all development dependencies, since the Gemfile is only used in development

# Pry, and IRB alternative
gem 'pry'
# Added  by `pry-plus` but needs to be locked to an earlier version
gem 'pry-stack_explorer', '0.4.9.3'
# Pry Rails extensions
gem 'pry-rails'
# Pry addons, from K&R repo
gem 'pry-plus', github: 'K-and-R/pry-plus'

# RSpec, and its Rails integration for testing
gem 'rspec-rails', '>= 4.0.1'

# Rubocop for ensuring well written code
gem 'rubocop', '>= 1.0'
# Rubocop performance evaluation
gem 'rubocop-performance', '>= 1.0'
# Rubocop RSpec evaluation
gem 'rubocop-rspec', '>= 2.0'

# Simplecov for code coverage reporting
# gem 'simplecov', '>= 0.20.0'
gem 'simplecov', '>= 0.17.0', '< 0.18'

# For generating documentation
gem 'yard', '>= 0.7.0'
