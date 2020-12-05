# frozen_string_literal: true

require 'spec_helper'

RSpec.describe EasyCaptcha::ViewHelpers, type: :helper do
  describe 'captcha_tag' do
    let(:captcha_path) { '/captcha' }

    it 'returns an image tag' do
      allow(helper).to receive(:captcha_path).and_return(captcha_path)
      expect(helper.captcha_tag).to match(%r{^<img alt="captcha" .* src="#{captcha_path}" />$})
    end
  end
end
