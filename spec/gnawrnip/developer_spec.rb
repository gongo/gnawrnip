require 'spec_helper'
require 'gnawrnip/developer'

module Gnawrnip
  describe Developer do
    let(:developer) do
      Developer.new
    end

    before do
      Image.any_instance.stub(:analysis)
    end

    context 'No given Gnawrnip.max_frame_size' do
      describe '.develop' do
        before do
          Gnawrnip.max_frame_size = nil
          Developer.should_not_receive(:resize)
        end

        it { developer.develop(nil) }
      end
    end

    context 'Given Gnawrnip.max_frame_size' do
      context 'width larger than height.' do
        describe '.develop' do
          before do
            Gnawrnip.max_frame_size = 300
            Image.any_instance.stub(:width).and_return(640)
            Image.any_instance.stub(:height).and_return(480)
            Image.any_instance.should_receive(:resize).with(300, 225)
          end

          it { developer.develop(nil) }
        end
      end

      context 'height larger than width.' do
        describe '.develop' do
          before do
            Gnawrnip.max_frame_size = 400
            Image.any_instance.stub(:width).and_return(480)
            Image.any_instance.stub(:height).and_return(640)
            Image.any_instance.should_receive(:resize).with(300, 400)
          end

          it { developer.develop(nil) }
        end
      end

      context 'Given max_frame_size larger than original.' do
        describe '.develop' do
          before do
            Gnawrnip.max_frame_size = 1024
            Image.any_instance.stub(:width).and_return(640)
            Image.any_instance.stub(:height).and_return(480)
            Image.any_instance.should_not_receive(:resize)
          end

          it { developer.develop(nil) }
        end
      end
    end
  end
end
