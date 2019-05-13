# frozen_string_literal: true

RSpec.configure do |c|
  c.before(:each, type: :system) do
    driven_by :rack_test
  end

  c.before(:each, type: :system, js: true) do
    driven_by ENV['CI'] ? :selenium_remote : :chrome

    if ENV['CI']
      Capybara.server_port = '3000'
      ip_address = `ip route | awk '/scope/' | cut -f 8 -d " "`.delete("\n")
      Capybara.server_host = ip_address
      Capybara.app_host = "http://#{Capybara.current_session.server.host}:" \
                          "#{Capybara.current_session.server.port}"
      # Fix remote form uploads http://sauceio.com/index.php/2013/12/remote-file-uploads-with-selenium-capybara/
      Capybara.current_session.driver.browser.file_detector = lambda do |args|
        str = args.first.to_s
        str if File.exist?(str)
      end
    end
  end

  c.after(:each, type: :system, js: true) do
    if ENV['CI']
      Capybara.reset_sessions!
      Capybara.use_default_driver
      Capybara.app_host = nil
    end
  end
end
