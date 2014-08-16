require 'spec_helper'
require 'gnawrnip/screenshot'

module Gnawrnip
  describe Screenshot do
    context 'Not support save_screenshot' do
      describe '.tale' do
        before do
          allow_any_instance_of(GnawrnipTest::Session).to receive(:save_screenshot) do
            raise Capybara::NotSupportedByDriverError
          end
        end

        it 'should raise Capybara::NotSupportByDriverError' do
          expect { Screenshot.take }.to raise_error Capybara::NotSupportedByDriverError
        end
      end
    end

    context 'raise unknown error' do
      describe '.take' do
        before do
          allow_any_instance_of(GnawrnipTest::Session).to receive(:save_screenshot) do
            raise Timeout::Error
          end
        end

        context 'timeout' do
          before do
            now = Time.now
            allow(Time).to receive(:now).and_return(now, now + 3)
          end

          it 'should raise Timeout Error' do
            screenshot = Capybara.using_wait_time 2 do
              Screenshot.take
            end

            expect(screenshot).to be_nil
          end
        end
      end
    end

    context 'success screenshot' do
      describe '.take' do
        before do
          expect(Screenshot).to receive(:shot).once
        end

        it { Screenshot.take }
      end
    end
  end
end
