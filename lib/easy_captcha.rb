# frozen_string_literal: true

require 'rails'
require 'action_controller'
require 'active_record'
require 'active_support'

# Captcha-Plugin for Rails
module EasyCaptcha
  autoload :Espeak, 'easy_captcha/espeak'
  autoload :Captcha, 'easy_captcha/captcha'
  autoload :CaptchaController, 'easy_captcha/captcha_controller'
  autoload :ModelHelpers, 'easy_captcha/model_helpers'
  autoload :ViewHelpers, 'easy_captcha/view_helpers'
  autoload :ControllerHelpers, 'easy_captcha/controller_helpers'
  autoload :Generator, 'easy_captcha/generator'

  DEFAULT_CONFIG = {
    cache: false,
    cache_expire: nil,
    cache_temp_dir: nil,
    cache_size: 500,
    captcha_character_pool: %w[2 3 4 5 6 7 9 A C D E F G H J K L M N P Q R S T U X Y Z],
    captcha_character_count: 6,
    captcha_image_height: 40,
    captcha_image_width: 140
  }.freeze

  # Cache
  mattr_accessor :cache

  # Cache temp
  mattr_accessor :cache_temp_dir

  # Cache size
  mattr_accessor :cache_size

  # Cache expire
  mattr_accessor :cache_expire

  # Chars
  mattr_accessor :captcha_character_pool

  # Length
  mattr_accessor :captcha_character_count

  # Image dimensions
  mattr_accessor :captcha_image_height, :captcha_image_width

  class << self
    # to configure easy_captcha
    # for a sample look the readme.rdoc file
    def setup
      DEFAULT_CONFIG.map do |k, v|
        send("#{k}=", v) if respond_to? "#{k}=".to_sym
      end
      yield self if block_given?
    end

    def cache? #:nodoc:
      cache
    end

    # select generator and configure this
    def generator(generator = nil, &block)
      resolve_generator(generator, &block) unless generator.nil?
      @generator
    end

    def espeak=(state)
      @espeak = state.is_a?(TrueClass) ? Espeak.new : false
    end

    def espeak(&block)
      @espeak = Espeak.new(&block) if block_given?
      @espeak ||= false
    end

    def espeak?
      !espeak.is_a?(FalseClass)
    end

    def init
      require 'easy_captcha/routes'
      ActiveRecord::Base.include ModelHelpers
      ActionController::Base.include ControllerHelpers
      ActionView::Base.include ViewHelpers

      # set default generator
      generator :default
    end

    private

    def resolve_generator(generator, &block)
      generator = generator.to_s if generator.is_a? Symbol
      if generator.is_a? String
        generator.gsub!(/^[a-z]|\s+[a-z]/, &:upcase)
        generator = "EasyCaptcha::Generator::#{generator}".constantize
      end
      @generator = generator.new(&block)
    end
  end
end

EasyCaptcha.init
