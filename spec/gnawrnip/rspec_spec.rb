require 'spec_helper'
require 'gnawrnip/rspec'

module Gnawrnip
  describe 'Rspec' do
    let(:example) do
      group = ::RSpec::Core::ExampleGroup.describe('Feature')
      example = group.example('example', {}) { expect(true).to be_false }
      group.run(
        Class.new do
          def self.method_missing(name, *args, &block)
            # nooooooop
          end
        end
      )
      example
    end

    it 'should save screen shot at error' do
      expect(example.metadata[:turnip][:screenshot]).to eq "c2NyZWVuc2hvdA==\n"
    end
  end
end
