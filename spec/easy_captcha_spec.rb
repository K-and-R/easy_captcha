# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/spec_helper")

describe EasyCaptcha do
  describe '#setup' do
    context 'when using defaults' do
      it 'does not require a block to be given' do
        expect { described_class.setup }.not_to raise_error
      end

      it 'will use defaults if no block given' do
        described_class.setup
      end

      it 'has default generator' do
        expect(described_class.generator).to be_an(EasyCaptcha::Generator::Default)
      end
    end

    context 'when chaging defaults' do
      let(:captcha_config_options) do
        {
          cache: false,
          captcha_character_pool: %w[2 4 6 8 A E I O U],
          captcha_image_height: 6,
          captcha_image_width: 9,
          captcha_character_count: 6
        }
      end

      let(:generator_config_options) do
        {
          blur: true,
          blur_radius: 1,
          blur_sigma: 2,
          font_size: 24,
          font_fill_color: '#333333',
          font_stroke_color: '#000000',
          font_stroke: 0,
          font_family: File.expand_path('../resources/afont.ttf', __dir__),
          image_background_color: '#FFFFFF',
          implode: 0.1,
          sketch: true,
          sketch_radius: 3,
          sketch_sigma: 1,
          wave: true,
          wave_length: (60..100),
          wave_amplitude: (3..5)
        }
      end

      before do
        described_class.setup do |config|
          captcha_config_options.each { |k, v| config.send("#{k}=", v) }
          config.generator(:default) { |generator| generator_config_options.each { |k, v| generator.send("#{k}=", v) } }
        end
      end

      it 'does not cache' do
        expect(described_class).not_to be_cache
      end
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
        described_class.setup
      end

      it 'returns non-nil for config methods' do
        config_methods.each do |opt|
          expect(described_class.generator.send(opt)).not_to be_nil
        end
      end

      it 'raises NoMethodError on missing non-depracations' do
        expect { described_class.send(EasyCaptcha::DEPRECATED_METHODS.first) }.not_to raise_error(NoMethodError)
      end

      it 'does not raise NoMethodError on depracations' do
        expect { described_class.send(:a_missing_method) }.to raise_error(NoMethodError)
      end

      it 'does not respond_to? depracations' do
        expect(described_class).not_to respond_to(EasyCaptcha::DEPRECATED_METHODS.first)
      end

      it 'does not respond_to? missing non-depracations' do
        expect(described_class).not_to respond_to(:a_missing_method)
      end
    end
  end
end
