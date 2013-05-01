require 'turnip_formatter/step/failure'

module Gnawrnip
  module StepScreenshot
    #
    # @param  [String]  png_file  base64 encoded
    #
    def self.build(png_file)
      img = '<img src="data:image/png;base64,'
      img += png_file
      img += '" style="width: 90%; border: 2px solid black;" />'
      img
    end
  end
end

TurnipFormatter::Step::Failure.add_template :screenshot, Gnawrnip::StepScreenshot do
  example.metadata[:turnip][:screenshot]
end
