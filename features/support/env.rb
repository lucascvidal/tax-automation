# frozen_string_literal: true

require 'capybara'
require 'capybara/cucumber'
require 'capybara/cuprite'

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(app, window_size: [1200, 800],
                                     browser_options: { 'no-sandbox': nil,
                                                        'ignore-certificate-errors': nil },
                                     timeout: 10, headless: false)
end

Capybara.default_driver = :cuprite
