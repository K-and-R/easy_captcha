# frozen_string_literal: true

class EasyCaptcha::TestModel
  # Required dependency for ActiveModel::Errors
  extend ActiveModel::Naming

  include EasyCaptcha::ModelHelpers
  acts_as_easy_captcha

  attr_accessor :name
  attr_reader   :errors

  def initialize
    @errors = ActiveModel::Errors.new(self)
  end

  # For ActiveModel::Errors, the following methods are needed to be minimally implemented
  def read_attribute_for_validation(attr)
    send(attr)
  end

  def self.human_attribute_name(attr, _options = {})
    attr
  end

  def self.lookup_ancestors
    [self]
  end
end
