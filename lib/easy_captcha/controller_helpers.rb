# frozen_string_literal: true

module EasyCaptcha
  # rubocop:disable Metrics/ModuleLength
  # helper class for ActionController
  module ControllerHelpers
    def self.included(base) #:nodoc:
      base.class_eval do
        helper_method :valid_captcha?, :captcha_valid?
      end
    end

    # generate captcha image and return it as blob
    def generate_captcha
      Rails.logger.info("#{Time.now}: generate_captcha in EasyCaptcha. params: #{params}.")
      # create image
      image = generate_captcha_image
      # cache image
      cache_image(image) if EasyCaptcha.cache
      # return image
      image
    end

    # generate speech by captcha from session
    def generate_speech_captcha
      fail 'espeak disabled' unless EasyCaptcha.espeak?
      if EasyCaptcha.cache && cache_audio_file_exists?
        load_cache_audio_file
      else
        new_audio_captcha_file
      end
    end

    # return cache path of captcha image
    def captcha_cache_path
      "#{EasyCaptcha.cache_temp_dir}/#{current_captcha_code}.png"
    end

    # return cache path of speech captcha
    def speech_captcha_cache_path
      "#{EasyCaptcha.cache_temp_dir}/#{current_captcha_code}.wav"
    end

    # current active captcha from session
    def current_captcha_code
      session[:captcha] ||= generate_captcha_code
    end

    # generate captcha code, save in session and return
    # rubocop:disable Metrics/AbcSize, Naming/MemoizedInstanceVariableName
    def generate_captcha_code
      @captcha_code ||= begin
        length = EasyCaptcha.captcha_character_count
        # overwrite `current_captcha_code`
        session[:captcha] = Array.new(length) { EasyCaptcha.captcha_character_pool.sample }.join
        Rails.logger.info(
          "#{Time.now}: generate_captcha_code in EasyCaptcha. " \
          "session[:captcha]: #{session[:captcha]} " \
          "length: #{length}, " \
          "original length: #{EasyCaptcha.captcha_character_count} " \
          "chars count: #{EasyCaptcha.captcha_character_pool.size}."
        )
        session[:captcha]
      end
    end
    # rubocop:enable Metrics/AbcSize, Naming/MemoizedInstanceVariableName

    # validate given captcha code
    def captcha_valid?(code)
      return false if session[:captcha].to_s.blank? || code.to_s.blank?
      session[:captcha].to_s == code.to_s
    end
    alias_method :valid_captcha?, :captcha_valid?

    def captcha_invalid?(code)
      !captcha_valid?(code)
    end
    alias_method :invalid_captcha?, :captcha_invalid?

    # reset the captcha code in session for security after each request
    def reset_last_captcha_code!
      session.delete(:captcha)
    end

    private

    def ensure_cache_dir
      # create cache dir
      FileUtils.mkdir_p(EasyCaptcha.cache_temp_dir)
    end

    def cached_captcha_files
      ensure_cache_dir
      # select all generated captcha image files from cache
      Dir.glob("#{EasyCaptcha.cache_temp_dir}*.png")
    end

    # Grab random file from the cached files, return its file data
    # rubocop:disable Metrics/AbcSize
    def chose_image_from_cache
      cache_files = cached_captcha_files

      return nil if cache_files.size < EasyCaptcha.cache_size

      file              = File.open(cache_files.samlpe)
      session[:captcha] = File.basename(file.path, '.*')

      if file.mtime < EasyCaptcha.cache_expire.ago
        # remove expired cached image
        remove_cached_image_file(file)
        # return nil
        session[:captcha] = nil
      else
        # return file data from cache
        file.readlines.join
      end
    end
    # rubocop:enable Metrics/AbcSize

    def remove_cached_image_file(file)
      File.unlink(file.path)
      # remove speech version
      audio_file = file.path.gsub(/png\z/, 'wav')
      File.unlink(audio_file) if File.exist?(audio_file)
    end

    def cache_image(image)
      code = current_captcha_code
      # write captcha for caching
      File.open(captcha_cache_path(code), 'w') { |f| f.write image }
      # write speech file if u create a new captcha image
      EasyCaptcha.espeak.generate(code, speech_captcha_cache_path(code)) if EasyCaptcha.espeak?
    end

    def generate_captcha_image
      if EasyCaptcha.cache
        image = chose_image_from_cache
        return image if image
      end
      # Default, if cache not enabled or an expired cache image was chosen, make a new one
      Captcha.new(current_captcha_code).image
    end

    def load_cache_audio_file
      File.read(speech_captcha_cache_path)
    end

    def new_audio_captcha_file
      wav_file = Tempfile.new("#{current_captcha_code}.wav")
      EasyCaptcha.espeak.generate(current_captcha_code, wav_file.path)
      File.read(wav_file.path)
    end

    def cache_audio_file_exists?
      File.exist?(speech_captcha_cache_path)
    end
  end
  # rubocop:enable Metrics/ModuleLength
end
