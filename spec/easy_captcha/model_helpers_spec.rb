# frozen_string_literal: true

require 'spec_helper'

class EasyCaptchaTestModel
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

RSpec.describe EasyCaptcha::ModelHelpers, type: :helpers do
  let(:model) { EasyCaptchaTestModel.new }

  it 'is included in the ActiveRecord helpers' do
    expect(ActiveRecord::Base).to include described_class
  end

  context 'when included in a model instance' do
    it 'has `captcha` reader' do
      expect(model).to respond_to :captcha
    end

    it 'has `captcha` writer' do
      expect(model).to respond_to :captcha=
    end

    it 'has `captcha_verification` writer' do
      expect(model).to respond_to :captcha_verification=
    end

    it 'has `captcha_valid?` method' do
      expect(model).to respond_to :captcha_valid?
    end

    it 'has `captcha_verification_match?` method' do
      expect(model).to respond_to :captcha_verification_match?
    end

    it 'is not valid with a `nil` CAPTCHA' do
      model.captcha = nil
      model.captcha_verification = nil
      expect(model).not_to be_valid_captcha
    end

    it 'is not valid with a `nil` CAPTCHA verification text' do
      model.captcha = 'foo'
      model.captcha_verification = nil
      expect(model).not_to be_valid_captcha
    end

    it 'is not valid with mismatched CAPTCHA and verification text' do
      model.captcha = 'foo'
      model.captcha_verification = 'bar'
      expect(model).not_to be_valid_captcha
    end

    it 'is valid with matching CAPTCHA and verification text' do
      model.captcha = 'foo'
      model.captcha_verification = 'foo'
      expect(model).to be_valid_captcha
    end

    it 'is valid with matching CAPTCHA and verification text with mismatched case' do
      model.captcha = 'Foo'
      model.captcha_verification = 'foo'
      expect(model).to be_valid_captcha
    end
  end
end
