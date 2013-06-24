require 'spec_helper'
require 'gnawrnip/animation'

module Gnawrnip
  describe Animation do
    before do
      Animation.reset!
      Animation.add_frame
      Animation.add_frame
    end

    describe '.add_frame' do
      subject { Animation.frames }
      it { should have(2).elements }
    end

    describe '.reset!' do
      before { Animation.reset! }
      subject { Animation.frames }
      it { should be_empty }
    end
  end
end
