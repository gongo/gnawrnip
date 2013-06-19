require 'spec_helper'
require 'gnawrnip/screenshot'

module Gnawrnip
  describe Screenshot do
    describe '.take' do
      subject { Screenshot.take.read }

      # see GnawrnipTestSession::save_screenshot
      it { should == 'screenshot' }
    end
  end
end
