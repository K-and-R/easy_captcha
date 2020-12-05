# frozen_string_literal: true

require 'active_support/all'
require 'action_controller'
require 'action_dispatch'
require 'action_view'

class EasyCaptcha::TestApp < ::Rails::Application
  def env_config; {} end
  def routes
    return @routes unless !defined?(@routes) || @routes.nil?
    @routes = ActionDispatch::Routing::RouteSet.new
    @routes
  end
end

module Rails
  def self.application
    @app ||= EasyCaptcha::TestApp.new
  end
end
Rails.application.routes.draw do
  captcha_route
end
