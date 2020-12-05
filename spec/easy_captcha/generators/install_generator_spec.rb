# frozen_string_literal: true

require 'fileutils'
require 'spec_helper'
require 'generator_spec'

require 'generators/easy_captcha/install_generator'

RSpec.describe EasyCaptcha::Generators::InstallGenerator, type: :generator do
  temp_dir = File.expand_path('../../../tmp', __dir__)
  destination temp_dir

  # rubocop:disable RSpec/BeforeAfterAll
  before(:all) do
    prepare_destination
    # Replicate a Rails app structure
    FileUtils.mkdir_p "#{temp_dir}/config/initializers"
    File.open "#{temp_dir}/config/routes.rb", 'w' do |f|
      f.write "Rails.application.routes.draw do \nend"
    end
    FileUtils.mkdir_p "#{temp_dir}/app/controllers"
    File.open "#{temp_dir}/app/controllers/application_controller.rb", 'w' do |f|
      f.write "class ApplicationController \nend"
    end
    # Ensure taht `ApplicationController` is already defined.
    require "#{temp_dir}/app/controllers/application_controller.rb"
    run_generator
  end

  after(:all) do
    FileUtils.rm_rf "#{temp_dir}/config"
    FileUtils.rm_rf "#{temp_dir}/app"
  end
  # rubocop:enable RSpec/BeforeAfterAll

  # rubocop:disable Lint/AmbiguousBlockAssociation
  specify do
    expect(destination_root).to have_structure {
      directory('config') do
        directory('initializers') do
          file('easy_captcha.rb') do
            contains('EasyCaptcha.setup')
          end
        end
      end
    }
  end

  specify do
    expect(destination_root).to have_structure {
      directory('app') do
        directory('controllers') do
          file('application_controller.rb') do
            contains('reset_last_captcha_code!')
          end
        end
      end
    }
  end

  specify do
    expect(destination_root).to have_structure {
      directory('config') do
        file('routes.rb') do
          contains('captcha_route')
        end
      end
    }
  end
  # rubocop:enable Lint/AmbiguousBlockAssociation
end
