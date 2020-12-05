# frozen_string_literal: true

EasyCaptcha.setup do |config|
  # #####
  # # Cache
  # config.cache                   = true
  # # Cache temp dir from Rails.root
  # config.cache_temp_dir          = Rails.root + 'tmp' + 'captchas'
  # # Cache max number of images to cache
  # config.cache_size              = 500
  # # Cache max length of time to cache an image
  # config.cache_expire            = 1.days
  #
  # #####
  # # CAPTCHA
  # # Chars available for CAPTCHA
  # config.captcha_character_pool  = %w(2 3 4 5 6 7 9 A C D E F G H J K L M N P Q R S T U X Y Z)
  #
  # # Length of CAPTCHA string
  # config.captcha_character_count = 6
  #
  # # CAPTCHA Image dimensions
  # config.captcha_image_height    = 40
  # config.captcha_image_width     = 140

  # #####
  # # eSpeak
  # # Enable eSpeak using all defaults:
  # config.espeak = true
  #
  # # Enable eSpeak using custom config:
  # config.espeak do |espeak|
  #   Amplitude, 0 to 200
  #   espeak.amplitude = 80..120
  #
  #   Word gap. Pause between words
  #   espeak.gap = 80
  #
  #   Pitch adjustment, 0 to 99
  #   espeak.pitch = 30..70
  #
  #   Use voice file of this name from espeak-data/voices
  #   espeak.voice = nil
  # end

  # #####
  # # Generator
  # config.generator :default do |generator|
  #   # Blur
  #   generator.blur                   = true
  #   generator.blur_radius            = 1
  #   generator.blur_sigma             = 2
  #
  #   # Font
  #   generator.font_family            = File.expand_path('../../resources/afont.ttf', __FILE__)
  #   generator.font_fill_color        = '#333333'
  #   generator.font_size              = 24
  #   generator.font_stroke            = 0
  #   generator.font_stroke_color      = '#000000'
  #
  #   # Image
  #   generator.image_background_color = "#FFFFFF"
  #
  #   # Implode
  #   generator.implode                = 0.1
  #
  #   # Sketch
  #   generator.sketch                 = true
  #   generator.sketch_radius          = 3
  #   generator.sketch_sigma           = 1
  #
  #   # Wave
  #   generator.wave                   = true
  #   generator.wave_amplitude         = (3..5)
  #   generator.wave_length            = (60..100)
  # end
end
