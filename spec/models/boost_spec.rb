require 'spec_helper'

describe Boost do
  describe 'apply!' do
    it 'should raise error' do
      expect { Boost.new.apply!(nil) }.to raise_error(NotImplementedError)
    end
  end

  describe 'discard!' do
    it 'should raise error' do
      expect { Boost.new.discard!(nil) }.to raise_error(NotImplementedError)
    end
  end
end
