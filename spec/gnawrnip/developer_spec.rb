require 'spec_helper'
require 'gnawrnip/developer'

module Gnawrnip
  describe Developer do
    let(:developer) { described_class.new }

    before do
      allow_any_instance_of(Image).to receive(:analysis)
    end

    context 'No given Gnawrnip.max_frame_size' do
      describe '.develop' do
        before do
          Gnawrnip.max_frame_size = nil
          expect(Developer).not_to receive(:resize)
        end

        it { developer.develop(nil) }
      end
    end

    context 'Given Gnawrnip.max_frame_size' do
      context 'width larger than height.' do
        describe '.develop' do
          before do
            Gnawrnip.max_frame_size = 300
            allow_any_instance_of(Image).to receive(:width).and_return(640)
            allow_any_instance_of(Image).to receive(:height).and_return(480)
            expect_any_instance_of(Image).to receive(:resize).with(300, 225)
          end

          it { developer.develop(nil) }
        end
      end

      context 'height larger than width.' do
        describe '.develop' do
          before do
            Gnawrnip.max_frame_size = 400
            allow_any_instance_of(Image).to receive(:width).and_return(480)
            allow_any_instance_of(Image).to receive(:height).and_return(640)
            expect_any_instance_of(Image).to receive(:resize).with(300, 400)
          end

          it { developer.develop(nil) }
        end
      end

      context 'Given max_frame_size larger than original.' do
        describe '.develop' do
          before do
            Gnawrnip.max_frame_size = 1024
            allow_any_instance_of(Image).to receive(:width).and_return(640)
            allow_any_instance_of(Image).to receive(:height).and_return(480)
            expect_any_instance_of(Image).not_to receive(:resize)
          end

          it { developer.develop(nil) }
        end
      end
    end
  end
end
