# frozen_string_literal: true

module EasyCaptcha
  # module for generators
  module Generator
    autoload :Base, 'easy_captcha/generator/base'
    autoload :Default, 'easy_captcha/generator/default'
  end
end
