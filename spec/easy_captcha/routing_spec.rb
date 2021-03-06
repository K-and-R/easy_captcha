# frozen_string_literal: true

require 'spec_helper'

require 'fixtures/application'

RSpec.describe EasyCaptcha::CaptchaController, type: :routing do
  routes { Rails.application.routes }
  let(:routeset) { Rails.application.routes }
  let(:captcha_request) { { get: '/captcha' } }

  it 'has added a route' do
    expect(routeset.routes.count).to eq 1
  end

  it 'has added a named route' do
    expect(routeset.named_routes.count).to eq 1
  end

  it 'has added a named `:captcha` route' do
    expect(routeset.named_routes.first.second.name).to eq 'captcha'
  end

  it 'makes `/captcha` URL routable' do
    expect(captcha_request).to be_routable
  end

  it 'has `/captcha` URL handled by `easy_captcha/captcha_controller#captcha`' do
    expect(captcha_request).to route_to(
      controller: 'easy_captcha/captcha',
      action: 'captcha'
    )
  end
end
