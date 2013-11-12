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

module TurnipFormatter
  Template.add_js_file('http://cdnjs.cloudflare.com/ajax/libs/jquery.cycle2/20130801/jquery.cycle2.min.js')

  Template.add_js(<<-EOS)
    $(function() {
        $('.screenshot.animation').each(function() {
            var slide = $(this).cycle({
                timeout: #{Gnawrnip.frame_interval.to_s},
                pager: "+ div.nav > .pager"
            });

            var nav = $(this).siblings('div.nav');
            var playButton = nav.find('.play');
            var stopButton = nav.find('.stop');

            var coloringOfStopped = function() {
                playButton.removeClass("selected");
                stopButton.addClass("selected");
            };

            var coloringOfPlaying = function() {
                playButton.addClass("selected");
                stopButton.removeClass("selected");
            };

            playButton.click(function() { slide.cycle('resume'); });
            stopButton.click(function() { slide.cycle('pause'); });

            slide.on('cycle-pager-activated', function(event, opts) {
                slide.cycle('pause');
            });

            slide.on('cycle-paused', function(event, opts) {
                coloringOfStopped();
            });

            slide.on('cycle-resumed', function(event, opts) {
                coloringOfPlaying();
            });
        });
    });
  EOS
end
