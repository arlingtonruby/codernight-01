require "spec_helper"
RATES_PATH = File.expand_path("../../data/SAMPLE_RATES.xml", __FILE__)
TRANS_PATH = File.expand_path("../../data/SAMPLE_TRANS.csv", __FILE__)

describe Reducer do

  subject(:reducer) { Reducer.new("DM1182", "USD") }

  context "when initialized" do
    
    it "sets sku, currency, and rates" do
      expect(reducer.sku).to eql("DM1182")
      expect(reducer.currency).to eql("USD")
      expect(reducer.rates).to be_an_instance_of Nokogiri::XML::Document
      expect(File.exists? reducer.transactions_path).to be_true
    end

  end

  context "when called" do

    it "calculates the sum" do
      sum = reducer.call
      expect(sum).to eql(134.22)
    end

  end

end