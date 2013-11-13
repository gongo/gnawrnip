require 'base64'

module Gnawrnip
  class Publisher

    #
    # @params [Array]  paths  Array of screenshot image filename
    #
    def animation(paths)
      paths.map { |path| image_tag(path) }.join
    end

    #
    # @params [string]  path  Screenshot image filename
    #
    def single(path)
      image_tag(path)
    end

    private

      def image_tag(path, format = :png)
        %Q|<img src="data:image/#{format.to_s};base64,#{image_base64(path)}"/>|
      end

      def image_base64(path)
        Base64.strict_encode64(File.read(path))
      end
  end
end
