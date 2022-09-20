require 'rails_helper'
require "capybara/cuprite"

Capybara.javascript_driver = :cuprite
# Capybara.javascript_driver = :selenium_chrome

Capybara.register_driver(:cuprite) do |app|
  browser_options = {}.tap do |opts|
    opts["no-sandbox"] = nil if ENV["CI"]
  end

  Capybara::Cuprite::Driver.new(app, window_size: [1200, 800], browser_options: browser_options, process_timeout: 70)
end