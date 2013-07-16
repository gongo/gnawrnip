require 'gnawrnip/publisher'
require 'turnip_formatter/template'

module Gnawrnip
  module Publisher
    class JS
      include Gnawrnip::Publisher

      def animation(images)
        images.map { |img| single(img) }.join
      end
    end
  end
end

TurnipFormatter::Template.add_js(<<-EOS)
  $(function() {
    $('.screenshot.animation').each(function() {
        var imgs = $(this).children('img');
        var frame = 0;

        imgs.hide();
        setInterval(function() {
            imgs.hide();
            imgs.eq(frame).show();
            frame = (++frame % imgs.length);
        }, #{Gnawrnip.frame_interval.to_s});
    });
  });
EOS
