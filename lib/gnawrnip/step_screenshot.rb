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
          description_no_screenshot
        when 1
          still_image(png_base64_list.first)
        else
          animation_image(png_base64_list)
        end
      end

      def description_no_screenshot
        @no_screenshot ||= description_frame(:no_screenshot)
        still_image(@no_screenshot)
      end

      def animation_image(images)
        text = '<div class="screenshot animation">'
        text += images.map { |data| img_tag(data) }.join
        text + '</div>'
      end

      def still_image(data)
        '<div class="screenshot">' + img_tag(data) + '</div>'
      end

      def img_tag(data)
        '<img src="data:image/png;base64,' + data + '"/>'
      end

      def description_frame(scene)
        path = File.dirname(__FILE__) + "/#{scene.to_s}.png"
        Base64.strict_encode64(File.read(path))
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
                 width: 90%;
                 border: 2px solid black;
               }
           }
       }
    }
  EOS

  Template.add_js(<<-EOS)
    $(function() {
        $('.screenshot.animation').each(function() {
            var imgs = $(this).children('img');
            var frame = 0;

            imgs.hide();
            setInterval(function() {
                imgs.hide();
                imgs.eq(frame).show();
                frame = (++frame % imgs.length);
            }, 1000);
        });
    });
  EOS

  Step::Failure.add_template Gnawrnip::StepScreenshot do
    example.metadata[:gnawrnip][:screenshot] || []
  end
end
