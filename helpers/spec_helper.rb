# frozen_string_literal: true

require 'rspec'
require_relative 'allure_helper'
require_relative 'browser_helper'

module SpecHelper

  AllureHelper.configure
  RSpec.configure do |config|
    config.formatter = AllureHelper.formatter
    config.include(BrowserHelper)

    config.after(:each) do
      example_name = self.class.descendant_filtered_examples.first.description
      browser.screenshot.save("allure-results/screenshots/#{example_name}.png")
       AllureHelper.add_screenshot example_name
      browser.quit
    end
  end
end