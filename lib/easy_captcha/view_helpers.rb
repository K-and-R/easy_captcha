# frozen_string_literal: true

module EasyCaptcha
  # helper class for ActionView
  module ViewHelpers
    # generate an image_tag for captcha image
    def captcha_tag(*args)
      options = { alt: 'captcha', width: EasyCaptcha.captcha_image_width, height: EasyCaptcha.captcha_image_height }
      options.merge! args.extract_options!
      image_tag(captcha_path(i: Time.now.to_i), options)
    end
  end
end
