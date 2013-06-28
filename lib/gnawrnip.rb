require "gnawrnip/version"
require 'gnawrnip/rmagick/photographer'
require 'gnawrnip/ext/capybara/session'
require 'gnawrnip/animation'
require 'gnawrnip/screenshot'
require 'gnawrnip/step_screenshot'
require 'gnawrnip/rspec'

module Gnawrnip
  class << self
    attr_accessor :photographer_driver
    attr_accessor :frame_interval

    def configure
      yield self
    end

    def ready!
      photographer # Try to load driver library.
    end

    def photographer
      @photographer ||= case photographer_driver
                        when :rmagick
                          require 'gnawrnip/rmagick/photographer'
                          @photographer = RMagick::Photographer.new
                        else # :js
                          require 'gnawrnip/js/photographer'
                          @photographer = JS::Photographer.new
                        end
    end
  end
end

Gnawrnip.configure do |c|
  c.frame_interval = 1000
  c.photographer_driver = :js
end
