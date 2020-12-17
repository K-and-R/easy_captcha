# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'easy_captcha/version'

Gem::Specification.new do |s|
  s.name = 'kandr-easy_captcha'
  s.version = EasyCaptcha::VERSION

  s.required_ruby_version = '>= 2.5.0'
  s.required_rubygems_version = '>= 2.7.0'
  s.authors = ['Marco Scholl', 'Alexander Dreher', 'Karl Wilbur']
  s.date = '2011-09-15'
  s.summary = 'CAPTCHA Plugin for Rails'
  s.description = 'A simple CAPTCHA implementation for Rails 5+ based on RMagick.'
  s.email = 'karl@kandrsoftware.com'
  s.extra_rdoc_files = [
    'LICENSE.txt',
    'README.md'
  ]
  s.files = `git ls-files -- README.md LICENSE.txt lib/* resources/*`.split("\n")

  s.homepage = 'http://github.com/K-and-R/easy_captcha'
  s.licenses = ['MIT']
  s.rubygems_version = '3.1.4'

  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency('rails', ['>= 5.0.0'])

  if defined?(PLATFORM) && PLATFORM == 'java'
    s.add_runtime_dependency('rmagick4j', '>= 0.3.7')
  else
    s.add_runtime_dependency('rmagick', '>= 2.13.1')
  end
end
