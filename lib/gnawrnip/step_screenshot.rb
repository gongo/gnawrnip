require 'base64'
require 'turnip_formatter/template'
require 'turnip_formatter/step/failure'

module Gnawrnip
  module StepScreenshot
    class << self
      #
      # @param  [Array] images  array of Gnawrnip::Image
      #
      def build(images)
        case images.length
        when 0
          ''
        when 1
          single_image(images.first)
        else
          animation_image(images)
        end
      end

      def animation_image(paths)
        text = <<-EOS
          <div class="screenshot animation">
              <div class="nav">
                  <div class="pager"></div>
                  <div class="manipulate">
                      <i class="fa fa-2x fa-step-backward prev"></i>
                      <i class="fa fa-2x fa-play play"></i>
                      <i class="fa fa-2x fa-pause pause"></i>
                      <i class="fa fa-2x fa-step-forward next"></i>
                  </div>
              </div>
              <div class="slides">
        EOS
        text += Gnawrnip.publisher.animation(paths)
        text + <<-EOS
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
  Template.add_css_file('http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css')

  Template.add_js(<<-EOS)
    $(function() {
        $('.screenshot.animation').each(function() {
            var slide = $(this).find('.slides').cycle({
                timeout: #{Gnawrnip.frame_interval_ms},
                autoHeight: "calc",
                pager: $(this).find('div.nav .pager')
            });

            var nav = $(this).find('div.nav');
            var playButton  = nav.find('.play');
            var pauseButton = nav.find('.pause');
            var prevButton  = nav.find('.prev');
            var nextButton  = nav.find('.next');

            var setPauseManipulate = function() {
                playButton.show();
                pauseButton.hide();
                prevButton.show();
                nextButton.show();
            };

            var setPlayManipulate = function() {
                playButton.hide();
                pauseButton.show();
                prevButton.hide();
                nextButton.hide();
            };

            playButton.click(function() { slide.cycle('resume'); });
            pauseButton.click(function() { slide.cycle('pause'); });
            prevButton.click(function() { slide.cycle('prev'); });
            nextButton.click(function() { slide.cycle('next'); });

            setPlayManipulate();

            slide.on('cycle-pager-activated', function(event, opts) {
                slide.cycle('pause');
            });

            slide.on('cycle-paused', function(event, opts) {
                setPauseManipulate();
            });

            slide.on('cycle-resumed', function(event, opts) {
                setPlayManipulate();
            });
        });
    });
  EOS

  Template.add_scss(<<-EOS)
    div#steps-statistics section.scenario {
        ul.steps {
            div.screenshot {
               img {
                 max-width: 90%;
                 border: 2px solid black;
               }
            }

            div.screenshot.animation {
                > div.nav {
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
                        margin-bottom: 1em;

                        i {
                            color: black;
                            cursor: pointer;
                            margin-left: 0.3em;
                            margin-right: 0.3em;

                            &:hover {
                                color: #aa0000;
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
