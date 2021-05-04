# frozen_string_literal: true

require 'spec_helper'

custom_captcha_config_options = {
  cache: false,
  captcha_character_pool: %w[2 4 6 8 A E I O U],
  captcha_image_height: 6,
  captcha_image_width: 9,
  captcha_character_count: 6
}

describe EasyCaptcha do
  it 'has a VERSION' do
    expect(described_class::VERSION).not_to be_blank
  end

  describe '#setup' do
    context 'when using defaults' do
      it 'does not require a block to be given' do
        expect { described_class.setup }.not_to raise_error
      end

      it 'has default generator' do
        expect(described_class.generator).to be_an(EasyCaptcha::Generator::Default)
      end

      context 'with default options' do
        before do
          described_class.setup
        end

        described_class::DEFAULT_CONFIG.map do |k, v|
          it "has #{k} value that matches the default config" do
            expect(described_class.send(k)).to eq v
          end
        end
      end
    end

    context 'when changing defaults' do
      before do
        described_class.setup do |config|
          custom_captcha_config_options.each { |k, v| config.send("#{k}=", v) }
        end
      end

      it 'does not cache' do
        expect(described_class).not_to be_cache
      end

      custom_captcha_config_options.map do |k, v|
        it "uses the `#{k}` value from the custom config" do
          expect(described_class.send(k)).to eq v
        end
      end
    end
  end
end
