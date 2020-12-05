# frozen_string_literal: true

Rails.logger = Logger.new('/dev/null')
class EasyCaptcha::TestController < ActionController::Base
  include ActionController::Helpers

  attr_accessor :controller_path, :session

  def initilaize(*args)
    @session = {}
    super
  end

  def params
    {}
  end
end
