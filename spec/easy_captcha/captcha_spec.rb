# frozen_string_literal: true

require 'spec_helper'

RSpec.describe EasyCaptcha::Captcha do
  let(:captcha_text) { 'asdf246' }
  let(:captcha) { described_class.new(captcha_text) }

  before do
    EasyCaptcha.setup
  end

  it 'uses new CAPTCHA text passed on initialization' do
    expect(captcha.code).to eq captcha_text
  end

  it 'generates a CAPTCHA on initialization' do
    expect(captcha.image).not_to be_nil
  end

  it 'shows its class name when inspected' do
    expect(captcha.inspect).to include described_class.name
  end

  it 'shows its code value when inspected' do
    expect(captcha.inspect).to include "@code=#{captcha_text}"
  end
end
