require 'coveralls'
Coveralls.wear!

require 'gnawrnip'

RSpec.configure do |config|
  config.include(
    Module.new do
      # stub Capybara::Session.save_screenshot
      def save_screenshot(file_path)
        File.open(file_path, 'w') do |fp|
          fp.print 'screenshot'
        end
      end
    end
  )
end
