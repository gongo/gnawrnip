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
