module ControllerRoutes
  extend ActiveSupport::Concern

  included do
    routes { Spina::Engine.routes }
  end
end

RSpec.configure do |c|
  c.include ControllerRoutes, type: :controller
end
