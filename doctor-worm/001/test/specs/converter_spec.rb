require 'test/test_helper'

project_dir = File.join(File.dirname(__FILE__), '..', '..')

describe Converter do
  rates = RatesParser.new(File.join(project_dir, 'sample/SAMPLE_RATES.xml'))
  sales = SalesParser.new(File.join(project_dir, 'sample/SAMPLE_TRANS.csv'))
  sku = "DM1182"

  subject do
    Converter.new(rates: rates, sales: sales, sku: sku)
  end

  describe 'class interace' do
    it 'has only getter for @rates' do
      subject.must_respond_to :rates
      subject.wont_respond_to :rates=
    end

    it 'has only getter for @sales' do
      subject.must_respond_to :sales
      subject.wont_respond_to :sales=
    end

    it 'has only getter for @sku' do
      subject.must_respond_to :sku
      subject.wont_respond_to :sku=
    end
  end

  # describe "sample conversion" do
  #   it 'calculates conversions' do
  #     subject.convert(amount: '1', from: 'AUD', to: 'CAD').must_equal '1.0079'
  #     subject.convert(amount: '1', from: 'CAD', to: 'AUD').must_equal '0.9922'
  #     subject.convert(amount: '1', from: 'CAD', to: 'USD').must_equal '1.0090'
  #     subject.convert(amount: '1', from: 'USD', to: 'CAD').must_equal '0.9911'
  #     subject.convert(amount: '1', from: 'AUD', to: 'USD').must_equal '0.9989'
  #     subject.convert(amount: '1', from: 'USD', to: 'AUD').must_equal '1.0011'
  #   end
  #   it 'outputs the correct data' do
  #     subject.product_revenue_total.must_equal '134.22'
  #   end
  # end
end
