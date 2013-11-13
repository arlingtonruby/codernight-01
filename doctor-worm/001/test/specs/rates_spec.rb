# probably don't have to test this
# consider it a sanity check?

require 'test/test_helper'

describe Rates do
  before do
    @rates = Rates.new(from: 'ABC', to: 'XYZ', rate: '3.14')
  end

  describe 'class signature' do
    it 'has getter and setter for data' do
      @rates.must_respond_to :from
      @rates.must_respond_to :to
      @rates.must_respond_to :rate
    end
  end

  describe 'given an initial hash' do
    it 'contains the correct data' do
      @rates.from.must_equal 'ABC'
      @rates.to.must_equal 'XYZ'
      @rates.rate.must_equal '3.14'
    end
  end
end
