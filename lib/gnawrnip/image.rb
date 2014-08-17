require 'fileutils'
require 'oily_png'

module Gnawrnip
  class Image
    #
    # @parma [String] filepath  Screenshot image filepath
    #
    def initialize(filepath)
      @filepath = filepath
      analysis
    end

    def to_html(format = :png)
      width  = width
      height = height
      src    = "data:image/#{format};base64,#{to_base64}"

      %Q(<img width="#{width}" height="#{height}" src="#{src}"/>)
    end

    #
    # @return [Fixnum] Width of image
    #
    def width
      @dimension.width
    end

    #
    # @return [Fixnum] Height of image
    #
    def height
      @dimension.height
    end

    def to_base64
      Base64.strict_encode64(File.read(@filepath))
    end

    def resize(width, height)
      canvas.resample_bilinear(width, height).save(@filepath)
      analysis
    end

    private

      #
      # Update dimension (OilyPNG::Dimension) of Image
      #
      def analysis
        @dimension = canvas.dimension
      end

      def canvas
        OilyPNG::Canvas.from_file(@filepath)
      end
  end
end
