require 'spec_helper'
require 'gnawrnip/screenshot'

module Gnawrnip
  describe Screenshot do
    describe '.take' do
      subject { Screenshot.take.read }

      context 'No given max frame size' do
        before do
          Screenshot.stub(:need_resize?) { false }
          Screenshot.should_not_receive(:resize)
        end

        # see GnawrnipTestSession::save_screenshot
        it { should == "screenshot" }
      end

      context 'No given max frame size' do
        before do
          Screenshot.stub(:need_resize?) { true }
          Screenshot.should_receive(:resize)
        end

        it { should == "screenshot" }
      end

      context 'not support save_screenshot' do
        before do
          GnawrnipTest::Session.any_instance.stub(:save_screenshot) do
            raise Capybara::NotSupportedByDriverError
          end
        end

        subject { lambda { Screenshot.take } }
        it { should raise_error Capybara::NotSupportedByDriverError }
      end

      context 'raise unknown error' do
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
  end
end
