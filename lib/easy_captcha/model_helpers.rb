# frozen_string_literal: true

module EasyCaptcha
  module ModelHelpers #:nodoc:
    # helper class for ActiveRecord
    def self.included(base) #:nodoc:
      base.extend ClassMethods
    end

    module ClassMethods #:nodoc:
      # to activate model captcha validation
      def acts_as_easy_captcha
        include InstanceMethods
        attr_accessor :captcha, :captcha_verification
      end
    end

    module InstanceMethods #:nodoc:
      # validate captcha
      def captcha_valid?
        return true if captcha.present? && captcha_verification.present? && captcha_verification_match?
        errors.add(:captcha, :invalid)
        false
      end
      alias_method :valid_captcha?, :captcha_valid?

      def captcha_verification_match?
        captcha.to_s.casecmp(captcha_verification.to_s).zero?
      end
    end
  end
end
