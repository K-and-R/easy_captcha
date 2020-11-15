# frozen_string_literal: true

require 'rmagick'

# EasyCaptcha module
module EasyCaptcha
  # Generator submodule
  module Generator
    # rubocop:disable Metrics/ClassLength
    # default generator
    class Default < Base
      DEFAULT_CONFIG = {
        background_image: nil,
        blur: true,
        blur_radius: 1,
        blur_sigma: 2,
        font: File.expand_path('../../../resources/captcha.ttf', __dir__),
        font_fill_color: '#333333',
        font_size: 24,
        font_stroke: 0,
        font_stroke_color: '#000000',
        image_background_color: '#FFFFFF',
        implode: 0.05,
        sketch: true,
        sketch_radius: 3,
        sketch_sigma: 1,
        wave: true,
        wave_amplitude: (3..5),
        wave_length: (60..100)
      }.freeze

      # set default values
      def defaults
        DEFAULT_CONFIG.map do |k, v|
          send("#{k}=", v)
        end
      end

      # Gaussian Blur
      attr_accessor :blur, :blur_radius, :blur_sigma

      # Font
      attr_accessor :font_size, :font_fill_color, :font, :font_family, :font_stroke, :font_stroke_color

      # Background
      attr_accessor :image_background_color, :background_image

      # Implode
      attr_accessor :implode

      # Sketch
      attr_accessor :sketch, :sketch_radius, :sketch_sigma

      # Wave
      attr_accessor :wave, :wave_length, :wave_amplitude

      # The CAPTCHA code
      attr_reader :code

      # The CAPTCHA image
      attr_reader :image

      def blur? #:nodoc:
        @blur
      end

      def sketch? #:nodoc:
        @sketch
      end

      def wave? #:nodoc:
        @wave
      end

      # generate image
      def generate(code)
        @code = code
        render_code_in_image
        apply_blur
        apply_wave
        apply_sketch
        apply_implode
        apply_crop
        create_blob
        set_image_encoding
        free_canvas
        @image
      end

      def create_blob
        @image = begin
          if generator_config.background_image.present?
            create_composite_blob
          else
            canvas.to_blob { self.format = 'PNG' }
          end
        end
      end

      def create_composite_blob
        # Background Random Position
        gravity = [
          Magick::CenterGravity,
          Magick::EastGravity,
          Magick::NorthEastGravity,
          Magick::NorthGravity,
          Magick::NorthWestGravity,
          Magick::SouthGravity,
          Magick::SouthEastGravity,
          Magick::SouthWestGravity,
          Magick::WestGravity
        ].sample

        background = Magick::Image.read(generator_config.background_image).first
        background.composite!(canvas, gravity, Magick::OverCompositeOp)
        background = background.crop(gravity, EasyCaptcha.captcha_image_width, EasyCaptcha.captcha_image_height)
        background.to_blob { self.format = 'PNG' }
      end

      def set_image_encoding
        @image = image.force_encoding 'UTF-8' if image.respond_to? :force_encoding
      end

      def free_canvas
        @canvas.destroy! if canvas.respond_to?('destroy!')
      end

      private

      def apply_blur
        return unless blur?
        @canvas = canvas.blur_image(generator_config.blur_radius, generator_config.blur_sigma)
      end

      def apply_crop
        # Crop image because to big after waveing
        @canvas = canvas.crop(Magick::CenterGravity, EasyCaptcha.captcha_image_width, EasyCaptcha.captcha_image_height)
      end

      def apply_implode
        @canvas = canvas.implode(generator_config.implode.to_f) if generator_config.implode.is_a? Float
      end

      def apply_sketch
        return unless sketch? && canvas.respond_to?(:sketch)
        @canvas = canvas.sketch(generator_config.sketch_radius, generator_config.sketch_sigma, rand(180))
      end

      def apply_wave
        return unless wave?
        @canvas = canvas.wave(random_wave_amplitude, random_wave_length)
      end

      def canvas
        config = generator_config
        @canvas = nil if @canvas&.destroyed?
        @canvas ||= Magick::Image.new(EasyCaptcha.captcha_image_width, EasyCaptcha.captcha_image_height) do |_variable|
          self.background_color = config.image_background_color unless config.image_background_color.nil?
          self.background_color = 'none' if config.background_image.present?
        end
      end

      def generator_config
        @generator_config ||= self
      end

      def random_wave_amplitude
        rand(
          generator_config.wave_amplitude.last - generator_config.wave_amplitude.first
        ) + generator_config.wave_amplitude.first
      end

      def random_wave_length
        rand(
          generator_config.wave_length.last - generator_config.wave_length.first
        ) + generator_config.wave_length.first
      end

      # rubocop:disable Metrics/AbcSize
      def render_code_in_image
        config = generator_config
        # Render the text in the image
        Magick::Draw.new.annotate(canvas, 0, 0, 0, 0, code.gsub(/%/, '\%')) do
          self.gravity     = Magick::CenterGravity
          self.font        = config.font
          self.font_weight = Magick::LighterWeight
          self.fill        = config.font_fill_color
          if config.font_stroke.to_i.positive?
            self.stroke       = config.font_stroke_color
            self.stroke_width = config.font_stroke
          end
          self.pointsize = config.font_size
        end
      end
      # rubocop:enable Metrics/AbcSize
    end
    # rubocop:enable Metrics/ClassLength
  end
end
