# frozen_string_literal: true

require 'fileutils'
require 'spec_helper'

require 'easy_captcha'

custom_generator_config_options = {
  background_color: '#abc123',
  background_fill: nil,
  background_image: nil,
  blur: true,
  blur_radius: 2,
  blur_sigma: 5,
  font_size: 20,
  font_fill_color: '#123456',
  font_stroke_color: '#fedcba',
  font_stroke: 2,
  font_family: File.expand_path('../resources/afont.ttf', __dir__),
  implode: 0.1,
  sketch: true,
  sketch_radius: 5,
  sketch_sigma: 2,
  wave: true,
  wave_length: (50..80),
  wave_amplitude: (2..8)
}

RSpec.describe EasyCaptcha::Generator::Default do
  let(:default_config) { described_class::DEFAULT_CONFIG }
  let(:length) { EasyCaptcha.captcha_code_length }
  let(:code) { Array.new(length) { EasyCaptcha.captcha_character_pool.sample }.join }

  before do
    EasyCaptcha.setup
  end

  context 'when using defaults' do
    let(:generator) { EasyCaptcha.generator }

    described_class::DEFAULT_CONFIG.map do |k, v|
      it "has #{k} value that matches the default config" do
        expect(generator.send(k)).to eq v
      end
    end

    context 'when generating an image' do
      it 'generates an image' do
        expect(generator.generate(code)).not_to be_empty
      end
    end
  end

  context 'when overriding defaults' do
    let(:generator) do
      described_class.new do |g|
        custom_generator_config_options.each { |k, v| g.send("#{k}=", v) }
      end
    end

    custom_generator_config_options.map do |k, v|
      it "uses the `#{k}` value from the custom config" do
        expect(generator.send(k)).to eq v
      end
    end

    context 'when generating an image' do
      it 'generates an image' do
        expect(generator.generate(code)).not_to be_empty
      end

      describe 'canvas' do
        let(:canvas) { generator.send(:canvas) }

        it 'has a row count that matches the defined captcha_image_height' do
          expect(canvas.rows).to eq EasyCaptcha.captcha_image_height
        end

        it 'has a columns count that matches the defined captcha_image_width' do
          expect(canvas.columns).to eq EasyCaptcha.captcha_image_width
        end

        it 'has a background color that matches the defined background_color code' do
          # RGB 8-bit hex codes (like `#abc123`) are converted to 16-bit (`#ababc1c12323`)
          # I would expect `#abc123` to become `#00ab00c10023`, but that's not what happens
          color_code = '#abc123'
          generator.background_color = color_code
          color_code_alnum = color_code[1..6]
          sixteen_bit_color_code = '#' + color_code_alnum.scan(/../).map { |color| color * 2 }.join.upcase # rubocop:disable Style/StringConcatenation
          expect(generator.send(:canvas).background_color).to eq sixteen_bit_color_code
        end

        it 'has a background color that matches the defined background_color name' do
          # Using a color name string like "red"
          color_name = 'red'
          generator.background_color = color_name
          expect(generator.send(:canvas).background_color).to eq color_name
        end

        it 'ignores the background_color value with using a `Fill` object' do
          generator.background_fill = Magick::GradientFill.new(0, 0, 0, 1000, '#990000', '#000000')
          # `nil` or `'none'` gets converted to `'black'`
          expect(generator.send(:canvas).background_color).to eq 'black'
        end
      end
    end
  end
end
