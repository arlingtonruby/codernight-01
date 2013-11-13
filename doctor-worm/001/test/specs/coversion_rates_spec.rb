require 'test/test_helper'

project_dir = File.join(File.dirname(__FILE__), '..', '..')

describe ConversionRates do
  # rates = RatesParser.new(File.join(project_dir, 'sample/SAMPLE_RATES.xml'))

  subject do
    # > rates.output
    # => [#<Rates:0x007fbd06d3ba88 @from="AUD", @rate="1.0079", @to="CAD">,
    # #<Rates:0x007fbd06d3ba38 @from="CAD", @rate="1.0090", @to="USD">,
    # #<Rates:0x007fbd06d3b9e8 @from="USD", @rate="0.9911", @to="CAD">]

    ConversionRates.new
    # ConversionRates.new(rates.output) # goal
  end

  describe 'class interface' do
    it 'responds to #aud2cad' do
      # binding.pry
      subject.must_respond_to :aud2cad # this doesn't work, but it should. works in pry.
    end
  end

  describe 'converts correctly' do
    subject.aud2cad(amount: '1 AUD').must_equal '1.0079'
  end
end
