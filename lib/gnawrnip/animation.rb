require 'gnawrnip/screenshot'
require 'base64'

module Gnawrnip
  class Animation
    class << self
      def reset!
        frames.clear
      end

      def frames
        @frames ||= []
      end

      def add_frame
        image = Screenshot.take
        frames << image
      end
    end
  end
end
