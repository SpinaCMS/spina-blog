# frozen_string_literal: true

RSpec.configure do |c|
  c.before(:each, type: :system) do
    driven_by :rack_test
  end

  c.before(:each, type: :system, js: true) do
    driven_by :chrome
  end
end
