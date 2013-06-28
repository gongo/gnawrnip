require 'tempfile'
require 'base64'

module Gnawrnip
  module Photographer
    def animation(paths)
      raise NotImplementedError
    end

    def single(path)
      image_tag(image_base64(path))
    end

    def image_base64(path)
      Base64.strict_encode64(File.read(path))
    end

    def image_tag(data, format = :png)
      '<img src="data:image/' + format.to_s + ';base64,' + data + '"/>'
    end
  end
end
