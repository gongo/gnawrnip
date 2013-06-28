require 'gnawrnip/photographer'
require 'turnip_formatter/template'

module Gnawrnip::JS
  class Photographer
    include Gnawrnip::Photographer

    def animation(images)
      images.map { |img| single(img) }.join
    end
  end
end

TurnipFormatter::Template.add_js(<<-EOS)
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
EOS
