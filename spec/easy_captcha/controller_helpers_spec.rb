# frozen_string_literal: true

require 'spec_helper'
require 'fixtures/application'
require 'fixtures/controller'

RSpec.describe 'EasyCaptcha::ControllerHelpers', type: :helper do
  let(:controller) { EasyCaptcha::TestController.new }

  before do
    EasyCaptcha.setup
  end

  it 'has a `valid_captcha?` method' do
    expect(helper).to respond_to :valid_captcha?
  end

  it 'has a `captcha_valid?` method' do
    expect(helper).to respond_to :captcha_valid?
  end
end
