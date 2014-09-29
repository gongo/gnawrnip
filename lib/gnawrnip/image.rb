require 'fileutils'
require 'oily_png'

module Gnawrnip
  class Image
    #
    # @parma [String] filepath  Screenshot image filepath
    #
    def initialize(filepath)
      @filepath = filepath
    end

    def to_html
      width  = canvas.width
      height = canvas.height
      src    = canvas.to_data_url

      %Q(<img width="#{width}" height="#{height}" src="#{src}"/>)
    end

    #
    # @return [Fixnum] Width of image
    #
    def width
      canvas.width
    end

    #
    # @return [Fixnum] Height of image
    #
    def height
      canvas.height
    end

    def resize(width, height)
      canvas.resample_bilinear!(width, height)
    end

    private

    def canvas
      @canvas ||= OilyPNG::Canvas.from_file(@filepath)
    end
  end
end
