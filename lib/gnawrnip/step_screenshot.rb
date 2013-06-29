require 'base64'
require 'turnip_formatter/template'
require 'turnip_formatter/step/failure'

module Gnawrnip
  module StepScreenshot
    class << self
      #
      # @param  [Array]  png_base64_list  array of base64 encoded image
      #
      def build(png_base64_list)
        case png_base64_list.length
        when 0
          ''
        when 1
          single_image(png_base64_list.first)
        else
          animation_image(png_base64_list)
        end
      end

      def animation_image(paths)
        text = '<div class="screenshot animation">'
        text += Gnawrnip.photographer.animation(paths)
        text + '</div>'
      end

      def single_image(path)
        text = '<div class="screenshot">'
        text += Gnawrnip.photographer.single(path)
        text + '</div>'
      end
    end
  end
end

module TurnipFormatter
  Template.add_scss(<<-EOS)
    div#steps-statistics section.scenario {
        ul.steps {
            div.screenshot {
               > img {
                 max-width: 90%;
                 border: 2px solid black;
               }
           }
       }
    }
  EOS

  Step::Failure.add_template Gnawrnip::StepScreenshot do
    example.metadata[:gnawrnip][:screenshot] || []
  end
end
