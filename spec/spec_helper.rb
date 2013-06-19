require 'coveralls'
Coveralls.wear!

require 'gnawrnip'
require 'capybara'

class GnawrnipTestSession
  def save_screenshot(file_path)
    File.open(file_path, 'w') do |fp|
      fp.print 'screenshot'
    end
  end

  def method_missing(name, *args, &block)
    # nooooooop
  end
end

module Capybara
  def self.current_session
    GnawrnipTestSession.new
  end
end
