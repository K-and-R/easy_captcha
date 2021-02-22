# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## 0.10.0 (2021-02-22)

* [karlwilbur] - Use `kandr-pry-plus` gem instead of the stale and broken `pry-plus`
* [karlwilbur] - Reset CAPTCHA code on subsequent requests for a new image/audio file
* [karlwilbur] - Add motion blur, using same blur values, when blur is used
* [karlwilbur] - Add support for a range of CAPTCHA characters
* [karlwilbur] - Updates to `README.md`

## 0.9.2 (2020-12-16)

* [karlwilbur] - [gemspec] Fix files included in gem
* [karlwilbur] - Add `bin/` script to push coverage report to CodeClimate

## 0.9.1 (2020-12-06)

### Additions

* [karlwilbur] - Add Travis CI badge to `README`

### Modifications/Fixes

* [karlwilbur] - Fix `Magick::Image#destroyed?` method guard syntax for jRuby support
* [karlwilbur] - Loosen Rubygems dependency from `>= 3.0.0` to `>= 2.7.0`
* [karlwilbur] - Group `development` gems to exclude them from CI builds

## 0.9.0 (2020-12-05)

### Additions

* [karlwilbur] - Add tests for:

    - `EasyCaptcha::Captcha`
    - `EasyCaptcha::CaptchaController`
    - `EasyCaptcha::ControllerHelpers`
    - `EasyCaptcha::ModelHelpers`
    - `EasyCaptcha::ViewHelpers`
    - `EasyCaptcha::Espeak` WAV file generation
    - `EasyCaptcha::Generators::InstallGenerator`

* [karlwilbur] - Add `mdl` gem dev dependency; run linters using `bundle exec`
* [karlwilbur] - Add `CHANGELOG`
* [karlwilbur] - Add CodeClimate badges to `README`

### Modifications/Fixes

* [karlwilbur] - Refactor `EasyCaptcha::Espeak` to use `DEFAULT_CONFIG` constant
* [karlwilbur] - Reduce complexity of `EasyCaptcha::Espeak#generate`
* [karlwilbur] - Reduce complexity of `EasyCaptcha#generator`
* [karlwilbur] - Fix logic in `EasyCaptcha::ModelHelper#captcha_valid?`
* [karlwilbur] - Fix bug in audio CAPTCHA generation
* [karlwilbur] - Modify comments and order of config options in initializer template
* [karlwilbur] - Allow `EasyCaptcha#setup` to be called without a block to use defaults
* [karlwilbur] - Lock Simplecov version until CodeClimate Test Reporter is updated

### Deletions/Removals

* [karlwilbur] - Remove deprecation warnings for deprecated methods which were already removed

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
