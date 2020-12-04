# frozen_string_literal: true

require 'spec_helper'

RSpec.describe EasyCaptcha::Espeak do
  context 'with default values' do
    subject(:captcha) { described_class.new }

    let(:amplitude_range) { 80..120 }
    let(:pitch_range) { 30..70 }

    specify(:amplitude) { expect(amplitude_range).to include(captcha.amplitude) }
    specify(:pitch) { expect(pitch_range).to include(captcha.pitch) }
    specify(:gap) { expect(captcha.gap).to eq 80 }
    specify(:voice) { expect(captcha.voice).to be_nil }
  end

  context 'with config: voices' do
    subject(:captcha) do
      described_class.new do |config|
        config.voice = voices
      end
    end

    let(:voices) { ['german', 'german+m1'] }

    specify { expect(voices).to include(captcha.voice) }
  end
end
