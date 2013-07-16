require "gnawrnip/version"
require 'gnawrnip/rspec'
require 'gnawrnip/photographer'
require 'gnawrnip/step_screenshot'

module Gnawrnip
  class << self
    attr_accessor :publisher_driver
    attr_accessor :frame_interval
    attr_accessor :frame_size
    attr_accessor :make_animation

    def configure
      yield self
    end

    def ready!
      require 'gnawrnip/ext/capybara/session' if animation?
      publisher
    end

    def animation?
      make_animation
    end

    def photographer
      @photographer ||= Gnawrnip::Photographer.new
    end

    def publisher
      @publisher ||= case publisher_driver
                     when :rmagick
                       require 'gnawrnip/publisher/rmagick'
                       @publisher = Publisher::RMagick.new
                     else # :js
                       require 'gnawrnip/publisher/js'
                       @publisher = Publisher::JS.new
                     end
    end
  end
end

Gnawrnip.configure do |c|
  c.publisher_driver = :js
  c.frame_interval   = 1000
  c.frame_size       = nil
  c.make_animation   = true
end
