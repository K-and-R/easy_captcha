# frozen_string_literal: true

module EasyCaptcha
  # espeak wrapper
  class Espeak
    # generator for captcha images
    def initialize
      defaults
      yield self if block_given?
    end

    # set default values
    def defaults
      send('amplitude=', 80..120)
      send('pitch=', 30..70)
      send('gap=', 80)
      send('voice=', nil)
    end

    attr_writer :amplitude, :pitch, :gap, :voice

    # return amplitude
    def amplitude
      @amplitude.is_a?(Range) ? @amplitude.to_a.sample : @amplitude.to_i
    end

    # return amplitude
    def pitch
      @pitch.is_a?(Range) ? @pitch.to_a.sample : @pitch.to_i
    end

    def gap
      @gap.to_i
    end

    def voice
      (@voice.is_a?(Array) ? @voice.sample : @voice).try(:gsub, /[^A-Za-z0-9\-+]/, '')
    end

    # generate wav file by captcha
    def generate(captcha, wav_file)
      cmd = ['espeak -g 10']
      cmd << "-a #{amplitude}" unless @amplitude.nil?
      cmd << "-p #{pitch}" unless @pitch.nil?
      cmd << "-g #{gap}" unless @gap.nil?
      cmd << "-v '#{voice}'" unless @voice.nil?
      cmd << "-w #{wav_file} '#{get_code(captcha)}'"

      `#{cmd.join(' ')}`
      true
    end

    def get_code(captcha)
      case captcha
      when Captcha
        code = captcha.code
      when String
        code = captcha
      else
        fail ArgumentError, 'invalid captcha'
      end
      # add spaces
      code.each_char.to_a.join(' ')
    end
  end
end
