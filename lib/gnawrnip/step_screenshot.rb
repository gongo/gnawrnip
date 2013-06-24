require 'turnip_formatter/step/failure'

module Gnawrnip
  module StepScreenshot
    #
    # @param  [String]  png_file  base64 encoded
    #
    def self.build(png_base64)
      img = '<img src="data:image/png;base64,'
      img += png_base64
      img += '" style="width: 90%; border: 2px solid black;" />'
      img
    end
  end
end

TurnipFormatter::Step::Failure.add_template :screenshot, Gnawrnip::StepScreenshot do
  example.metadata[:gnawrnip][:screenshot]
end
