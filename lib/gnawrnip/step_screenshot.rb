require 'turnip_formatter/step/failure'

module Gnawrnip
  module StepScreenshot
    #
    # @param  [String]  gif_file  base64 encoded
    #
    def self.build(gif_base64)
      img = '<img src="data:image/gif;base64,'
      img += gif_base64
      img += '" style="width: 90%; border: 2px solid black;" />'
      img
    end
  end
end

TurnipFormatter::Step::Failure.add_template :screenshot, Gnawrnip::StepScreenshot do
  example.metadata[:gnawrnip][:screenshot]
end
