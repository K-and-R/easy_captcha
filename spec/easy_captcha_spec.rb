# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/spec_helper")

describe EasyCaptcha do
  describe '#setup' do
    described_class.setup do |config|
      # Cache
      config.cache = false

      # Chars
      config.chars = %w[2 3 4 5 6 7 9 A C D E F G H J K L M N P Q R S T U X Y Z]

      # Image
      config.image_height = 40
      config.image_width = 140

      # Length
      config.length = 6

      # configure generator
      config.generator :default do |generator|
        # Blur
        generator.blur = true
        generator.blur_radius = 1
        generator.blur_sigma = 2

        # Font
        generator.font_size = 24
        generator.font_fill_color = '#333333'
        generator.font_stroke_color = '#000000'
        generator.font_stroke = 0
        generator.font_family = File.expand_path('../resources/afont.ttf', __dir__)

        # Image background
        generator.image_background_color = '#FFFFFF'

        # Implode
        generator.implode = 0.1

        # Sketch
        generator.sketch = true
        generator.sketch_radius = 3
        generator.sketch_sigma = 1

        # Wave
        generator.wave = true
        generator.wave_length = (60..100)
        generator.wave_amplitude = (3..5)
      end
    end

    it 'does not cache' do
      expect(described_class).not_to be_cache
    end

    it 'has default generator' do
      expect(described_class.generator).to be_an(EasyCaptcha::Generator::Default)
    end

    describe '#depracations' do
      let(:config_methods) do
        %i[
          blur
          blur_radius
          blur_sigma
          font_family
          font_fill_color
          font_size
          font_stroke
          font_stroke_color
          image_background_color
          implode
          sketch
          sketch_radius
          sketch_sigma
          wave
          wave_amplitude
          wave_length
        ]
      end

      before do
        described_class.setup do |config|
          # Image
          config.image_height = 40
          config.image_width = 140

          # Length
          config.length = 6

          config.generator :default do |generator|
            # Blur
            generator.blur = true
            generator.blur_radius = 1
            generator.blur_sigma = 2

            # Font
            generator.font_size = 24
            generator.font_fill_color = '#333333'
            generator.font_stroke_color = '#000000'
            generator.font_stroke = 0
            generator.font_family = File.expand_path('../resources/afont.ttf', __dir__)

            # Image background
            generator.image_background_color = '#FFFFFF'

            # Implode
            generator.implode = 0.1

            # Sketch
            generator.sketch = true
            generator.sketch_radius = 3
            generator.sketch_sigma = 1

            # Wave
            generator.wave = true
            generator.wave_length = (60..100)
            generator.wave_amplitude = (3..5)
          end
        end
      end

      it 'returns non-nil for config methods' do
        config_methods.each do |opt|
          expect(described_class.generator.send(opt)).not_to be_nil
        end
      end

      it 'raises method_missing on non-depracations' do
        expect { described_class.send(:a_missing_method) }.to raise_error(NoMethodError)
      end
    end
  end
end
