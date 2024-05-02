require 'capybara'
require 'capybara/cucumber'
require "capybara/cuprite"

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(app, window_size: [1200, 800], browser_options: { 'no-sandbox': nil }, timeout: 10)
end

Capybara.default_driver = :cuprite
Capybara.app_host = 'https://bancoabc-dev1.numerixms.com'
