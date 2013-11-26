require 'oily_png'

module Gnawrnip
  class Image
    #
    # @return [File] Screenshot image file (png)
    #
    attr_reader :file

    #
    # @parma [File] Screenshot image file (png)
    #
    def initialize(file)
      @file = file
      analysis
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

    def resize(width, height)
      canvas.resample_bilinear(width, height).save(file.path)
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
        OilyPNG::Canvas.from_file(file)
      end
  end
end
