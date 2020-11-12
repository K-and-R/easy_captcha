module ActionDispatch #:nodoc:
  module Routing #:nodoc:
    class Mapper #:nodoc:
      # call to add default captcha root
      def captcha_route
        match 'captcha' => EasyCaptcha::Controller, :action => :captcha, :via => :get, :as => :captcha
      end
    end
  end
end
