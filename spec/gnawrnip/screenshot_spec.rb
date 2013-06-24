require 'spec_helper'
require 'gnawrnip/screenshot'

module Gnawrnip
  describe Screenshot do
    describe '.take' do
      subject { Screenshot.take }

      # see GnawrnipTestSession::save_screenshot
      it { should == "c2NyZWVuc2hvdA==\n" }
    end
  end
end
