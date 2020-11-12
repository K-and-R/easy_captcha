module EasyCaptcha
  # espeak wrapper
  class Espeak

    # generator for captcha images
    def initialize(&block)
      defaults
      yield self if block_given?
    end

    # set default values
    def defaults
      @amplitude = 80..120
      @pitch     = 30..70
      @gap       = 80
      @voice     = nil
    end

    attr_writer :amplitude, :pitch, :gap, :voice

    # return amplitude
    def amplitude
      if @amplitude.is_a? Range
        @amplitude.to_a.sort_by { rand }.first
      else
        @amplitude.to_i
      end
    end

    # return amplitude
    def pitch
      if @pitch.is_a? Range
        @pitch.to_a.sort_by { rand }.first
      else
        @pitch.to_i
      end
    end

    def gap
      @gap.to_i
    end

    def voice
      if @voice.is_a? Array
        v = @voice.sort_by { rand }.first
      else
        v = @voice
      end

      v.try :gsub, /[^A-Za-z0-9\-\+]/, ""
    end

    # generate wav file by captcha
    def generate(captcha, wav_file)
      cmd = 'espeak -g 10'
      cmd << " -a #{amplitude}" unless @amplitude.nil?
      cmd << " -p #{pitch}" unless @pitch.nil?
      cmd << " -g #{gap}" unless @gap.nil?
      cmd << " -v '#{voice}'" unless @voice.nil?
      cmd << " -w #{wav_file} '#{get_code(captcha)}'"

      `#{cmd}`
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
