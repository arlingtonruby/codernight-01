require 'test/test_helper'

test_input = File.expand_path('../../sample/SAMPLE_RATES.xml', File.dirname(__FILE__))

describe RatesParser do
  subject do
    RatesParser.new(test_input)
  end

  describe 'class interface' do
    it 'has only a getter for #input' do
      subject.must_respond_to :input
      subject.wont_respond_to :input=
    end

    it 'has only a setter for #output' do
      subject.must_respond_to :output
      subject.wont_respond_to :output=
    end

  end

  describe 'load XML' do
    it 'returns an array of arrays' do
      subject.input.must_be_instance_of Array
      subject.input[0].must_be_instance_of Array
    end
  end

  describe 'output' do
    it 'outputs the correct data' do
      subject.output[0].from.must_equal 'AUD'
      subject.output[0].to.must_equal 'CAD'
      subject.output[0].rate.must_equal '1.0079'
    end
  end
end
