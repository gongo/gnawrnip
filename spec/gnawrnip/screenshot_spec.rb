require 'spec_helper'
require 'gnawrnip/screenshot'

module Gnawrnip
  describe Screenshot do
    context 'Not support save_screenshot' do
      describe '.tale' do
        before do
          GnawrnipTest::Session.any_instance.stub(:save_screenshot) do
            raise Capybara::NotSupportedByDriverError
          end
        end

        subject { lambda { Screenshot.take } }
        it { should raise_error Capybara::NotSupportedByDriverError }
      end
    end

    context 'raise unknown error' do
      describe '.take' do
        before do
          GnawrnipTest::Session.any_instance.stub(:save_screenshot) do
            raise Timeout::Error
          end
        end

        context 'timeout' do
          before do
            now = Time.now
            Time.stub(:now).and_return(now, now + 3)
          end

          subject do
            lambda {
              Capybara.using_wait_time 2 do
                Screenshot.take
              end
            }
          end

          it { should raise_error Timeout::Error }
        end
      end
    end

    context 'No given Gnawrnip.max_frame_size' do
      describe '.take' do
        subject { Screenshot.take.read }

        context 'No given max frame size' do
          before do
            Gnawrnip.max_frame_size = nil
            Screenshot.should_not_receive(:resize)
          end

          it { should == "screenshot" }
        end
      end
    end

    context 'Given Gnawrnip.max_frame_size' do
      before do
        OilyPNG::Canvas.stub(:from_file) { oily_png }
      end

      subject { Screenshot.take.read }

      context 'width larger than height.' do
        let(:oily_png) do
          oily_png = double('oily_png', width: 640, height: 480, save: nil)
          oily_png.should_receive(:resample_bilinear!).with(300, 225)
          oily_png
        end

        before do
          Gnawrnip.max_frame_size = 300
        end

        it { should == "screenshot" }
      end

      context 'height larger than width.' do
        let(:oily_png) do
          oily_png = double('oily_png', width: 480, height: 640, save: nil)
          oily_png.should_receive(:resample_bilinear!).with(300, 400)
          oily_png
        end

        before do
          Gnawrnip.max_frame_size = 400
        end

        it { should == "screenshot" }
      end

      context 'Given max_frame_size larger than original.' do
        let(:oily_png) do
          oily_png = double('oily_png', width: 640, height: 480, save: nil)
          oily_png.should_receive(:resample_bilinear!).with(640, 480)
          oily_png
        end

        before do
          Gnawrnip.max_frame_size = 1024
        end

        it { should == "screenshot" }
      end
    end
  end
end
