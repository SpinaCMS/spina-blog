# frozen_string_literal: true

Capybara.server = :puma, { Silent: true }

args = %w[no-sandbox disable-gpu window-size=1280,1024]
args << "lang=#{I18n.locale}"
args << 'headless' unless ENV['DEBUG']
capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
  chromeOptions: { args: args }
)

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(
    app, browser: :chrome, desired_capabilities: capabilities
  )
end

Capybara.register_driver :selenium_remote do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    desired_capabilities: capabilities,
    url: 'http://selenium:4444/wd/hub'
  )
end
