# frozen_string_literal: true

require 'spec_helper'

# require 'rails-controller-testing'
# Rails::Controller::Testing.install

require 'fixtures/application'
Rails.logger = Logger.new('/dev/null')

RSpec.describe EasyCaptcha::CaptchaController, type: :controller do
  let(:controller) { described_class.new }

  before do
    EasyCaptcha.init
    EasyCaptcha.setup do |config|
      config.cache = false
      config.espeak = true
    end
  end

  describe '`captcha` action' do
    it 'exists' do
      expect(controller).to respond_to :captcha
    end

    context 'with defaults' do
      before do
        get :captcha
      end

      it 'sends an image' do
        expect(response.header['Content-Type']).to eq 'image/png'
      end

      it 'sends content' do
        expect(response.body).not_to be_empty
      end
    end

    context 'with a WAV request' do
      before do
        get :captcha, format: 'wav'
      end

      it 'sends an audio file' do
        expect(response.header['Content-Type']).to eq 'audio/wav'
      end

      it 'sends content' do
        expect(response.body).not_to be_empty
      end
    end
  end
end
