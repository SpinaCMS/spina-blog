# frozen_string_literal: true

require 'rails-controller-testing'

RSpec.configure do |config|
  %i[controller view request].each do |type|
    config.include ::Rails::Controller::Testing::TestProcess, type: type
    config.include ::Rails::Controller::Testing::TemplateAssertions, type: type
    config.include ::Rails::Controller::Testing::Integration, type: type
  end

  config.include ::Rails::Controller::Testing::TemplateAssertions, type: :helper
end
