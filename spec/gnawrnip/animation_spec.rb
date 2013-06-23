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

    describe '.generate' do
      before do
        ::Magick::ImageList.any_instance.stub(:initialize) do |*filenames|
          @file_length = filenames.length
        end
        ::Magick::ImageList.any_instance.stub(:delay=)
        ::Magick::ImageList.any_instance.stub(:write) do |path|
          File.write(path, @file_length.to_s)
        end
      end

      subject { Animation.generate }
      it 'should be base64 encoded string for each files.' do
        should == "Mg==\n"
      end
    end
  end
end
