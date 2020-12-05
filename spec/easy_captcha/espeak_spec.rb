# frozen_string_literal: true

require 'spec_helper'

RSpec.describe EasyCaptcha::Espeak do
  before do
    # Ensure that we have created a config
    EasyCaptcha.setup
  end

  context 'with default values' do
    subject(:audio_captcha) { described_class.new }

    let(:amplitude_range) { 80..120 }
    let(:pitch_range) { 30..70 }

    specify(:amplitude) { expect(amplitude_range).to include(audio_captcha.amplitude) }
    specify(:pitch) { expect(pitch_range).to include(audio_captcha.pitch) }
    specify(:gap) { expect(audio_captcha.gap).to eq 80 }
    specify(:voice) { expect(audio_captcha.voice).to be_nil }

    context 'when generating WAV file' do
      let(:code) { 'asdf2648' }
      let(:wav_file) { Tempfile.new("#{code}.wav") }

      after do
        wav_file.close!
        wav_file.unlink
      end

      it 'generates without error' do
        expect { audio_captcha.generate(code, wav_file.path) }.not_to raise_error
      end

      it 'generates file content' do
        audio_captcha.generate(code, wav_file.path)
        expect(wav_file.size).not_to be_zero
      end

      it 'raises an ArgumentError with an invalid code' do
        expect { audio_captcha.generate(nil, wav_file.path) }.to raise_error ArgumentError
      end

      context 'with an `EasyCaptcha::Captcha` instance as its code' do
        let(:captcha_code_object) { EasyCaptcha::Captcha.new(code) }

        it 'can accept code argument without an error' do
          expect { audio_captcha.generate(captcha_code_object, wav_file.path) }.not_to raise_error
        end

        it 'can generate file content' do
          audio_captcha.generate(captcha_code_object, wav_file.path)
          expect(wav_file.size).not_to be_zero
        end
      end
    end
  end

  context 'with config: voices' do
    subject(:audio_captcha) do
      described_class.new do |config|
        config.voice = voices
      end
    end

    let(:voices) { ['german', 'german+m1'] }

    specify { expect(voices).to include(audio_captcha.voice) }
  end
end
