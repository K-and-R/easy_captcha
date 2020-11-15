# frozen_string_literal: true

module ActionDispatch #:nodoc:
  module Routing #:nodoc:
    class Mapper #:nodoc:
      # call to add default captcha root
      def captcha_route
        get '/captcha' => 'easy_captcha/captcha#captcha', action: :captcha, as: :captcha
      end
    end
  end
end
