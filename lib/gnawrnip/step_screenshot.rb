require 'base64'
require 'turnip_formatter/template'
require 'turnip_formatter/step/failure'

module Gnawrnip
  module StepScreenshot
    #
    # @param  [Array]  png_base64_list  array of base64 encoded image
    #
    def self.build(png_base64_list)
      case png_base64_list.length
      when 0
        no_screenshot_image
      when 1
        still_image(png_base64_list.first)
      else
        animation_image(png_base64_list)
      end
    end

    private

    def self.no_screenshot_image
      path = File.dirname(__FILE__) + '/noscreenshot.png'
      @no_screenshot_image ||= Base64.strict_encode64(File.read(path))
      still_image(@no_screenshot_image)
    end

    def self.animation_image(images)
      '<div class="screenshot animation">' + images.map { |data| img_tag(data) }.join + '</div>'
    end

    def self.still_image(data)
      '<div class="screenshot">' + img_tag(data) + '</div>'
    end

    def self.img_tag(data)
      '<img src="data:image/png;base64,' + data + '"/>'
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
