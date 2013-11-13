require 'test/test_helper'

test_input = File.expand_path('../../sample/SAMPLE_TRANS.csv', File.dirname(__FILE__))

describe SalesParser do
  subject do
    SalesParser.new(test_input)
  end

  describe 'class interface' do
    it 'has only a getter for #input' do
      subject.must_respond_to :input
      subject.wont_respond_to :input=
    end

    it 'has only a getter for #output' do
      subject.must_respond_to :output
      subject.wont_respond_to :output=
    end
  end

  describe 'load CSV' do
    it 'returns an array of arrays' do
      subject.input.must_be_kind_of Array
      subject.input[0].must_be_kind_of Array
    end
  end

  describe 'output' do
    it 'outputs the correct data' do
      subject.output[0].store.must_equal 'Yonkers'
      subject.output[0].sku.must_equal 'DM1210'
      subject.output[0].amount.must_equal '70.00 USD'
    end
  end
end
