require 'base64'
require 'turnip_formatter/template'
require 'turnip_formatter/step/failure'

module Gnawrnip
  module StepScreenshot
    class << self
      #
      # @param  [Array] png_base64_list  array of base64 encoded image
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
        text += Gnawrnip.publisher.animation(paths)
        text + <<-EOS
            </div>
            <div class="nav">
                <div class="pager"></div>
                <div class="manipulate">
                    <span class="play selected">&#9654;</span>
                    <span class="stop">&#9632;</span>
                </div>
            </div>
        EOS
      end

      def single_image(path)
        text = '<div class="screenshot">'
        text += Gnawrnip.publisher.single(path)
        text + '</div>'
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

  Template.add_scss(<<-EOS)
    div#steps-statistics section.scenario {
        ul.steps {
            div.screenshot {
               > img {
                 max-width: 90%;
                 border: 2px solid black;
               }
            }

            div.screenshot.animation {
                + div.nav {
                    text-align: center;

                    .pager {
                        margin-left: auto;
                        margin-right: auto;

                        span {
                            font-size: 50px;
                            display: inline;
                            color: #999999;
                            cursor: pointer;

                            &.cycle-pager-active {
                                color: red;
                            }
                        }
                    }

                    .manipulate {
                        span {
                            color: black;
                            font-size: 30px;
                            cursor: pointer;

                            &.selected {
                                color: red;
                            }
                        }
                    }
                }
            }
        }
    }
  EOS

  Step::Failure.add_template Gnawrnip::StepScreenshot do
    example.metadata[:gnawrnip][:screenshot] || []
  end
end
