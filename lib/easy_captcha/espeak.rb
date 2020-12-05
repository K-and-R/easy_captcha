# frozen_string_literal: true

module EasyCaptcha
  # espeak wrapper
  class Espeak
    DEFAULT_CONFIG = {
      amplitude: 80..120,
      pitch: 30..70,
      gap: 80,
      voice: nil
    }.freeze

    attr_writer :amplitude, :pitch, :gap, :voice

    # generator for captcha images
    def initialize
      set_defaults
      yield self if block_given?
    end

    # set default values
    def set_defaults
      DEFAULT_CONFIG.map do |k, v|
        send("#{k}=", v) if respond_to? "#{k}=".to_sym
      end
    end

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
      cmd = [
        'espeak -g 10',
        espeak_amplitude_param,
        espeak_pitch_param,
        espeak_gap_param,
        espeak_voice_param,
        "-w #{wav_file}",
        "'#{get_code(captcha)}'"
      ].compact.join(' ')

      `#{cmd}`
      true
    end

    def espeak_amplitude_param
      "-a #{amplitude}" unless @amplitude.nil?
    end

    def espeak_pitch_param
      "-p #{pitch}" unless @pitch.nil?
    end

    def espeak_gap_param
      "-g #{gap}" unless @gap.nil?
    end

    def espeak_voice_param
      "-v '#{voice}'" unless @voice.nil?
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
