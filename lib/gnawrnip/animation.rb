require 'gnawrnip/screenshot'
require 'RMagick'
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

      def generate
        gif = Tempfile.new(['gnawrnip_animation', '.gif'])
        image.write(gif.path)
        Base64.encode64(gif.read)
      end

      private

      def image
        paths = frames.map(&:path)
        images = Magick::ImageList.new(*paths)
        images.delay = 50
        images
      end
    end
  end
end
