# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## 0.9.0 (TBD)

* [karlwilbur] - Remove deprecation warnings for deprecated methods which were already removed
* [karlwilbur] - Allow `EasyCaptcha#setup` to be called without a block to use defaults
* [karlwilbur] - Add `mdl` gem dev dependency; run linters using `bundle exec`
* [karlwilbur] - Add `CHANGELOG`
* [karlwilbur] - Add CodeClimate badges to `README`
* [karlwilbur] - Lock Simplecov version until CodeClimate Test Reporter is updated

## 0.8.0 (2020-12-03)

* [karlwilbur] - Rename gem `easy_captcha` -> `kandr-easy_captcha` for publishing to Rubygems
* [karlwilbur] - Convert `README` from rdoc to Markdown
* [karlwilbur] - Fix `EasyCaptcha#respond_to_missing?` logic
* [karlwilbur] - Add pre-commit hook for linting and testing
* [karlwilbur] - Refactor for readibility/maintainability and delinting with help from Rubocop
* [karlwilbur] - Update RSpec tests
* [karlwilbur] - [gemset] Update gems
* [karlwilbur] - [gemspec/Gemfile] Move dev dependencies to `Gemfile`
* [karlwilbur] - [gemfile] Add Rubocop
* [karlwilbur] - [gemspec/gemfile] Update required Ruby and RubyGems versions; set contact info to K&R
* [karlwilbur] - Simplify audio CAPTCHA `generate` method
* [karlwilbur] - Separate CAPTCHA validation and verification
* [karlwilbur] - Add missing `end`
* [karlwilbur] - [gemset] Update gem versions

## 0.7.0 (2020-11-25)

* [karlwilbur] - Update `README.rdoc`
* [karlwilbur] - Remove `.ruby-gemset` file
* [karlwilbur] - Fix `.ruby-version`
* [aditiatama] - Rails 6 compatibility
* [gropher] - Routes fixed
* [mwxjs/unsyn] - bugfixes, logging
* [kopylovvlad] - Rails 5 compatibility
* [brunoporto] - Rails 4.1+ compatibility
* [brunoporto] - fix `font_stroke` and `font_stroke` color and improvements
* [brunoporto] - fix spec
* [forever-sumit] - use `_path` instead of `_url` helper
* [vaucn] - fix misspelling
* [matheusvilela] - fix captcha generation using `rmagick4j` `0.3.8`.

## 0.6

* espeak support for barrier-free support

## 0.5

* (transparent) background support

## 0.4

* generator support

## 0.3

* use generators, optimizations, update licence to same of all my plugins

## 0.2

* cache support for high frequented sites

## 0.1

* init
