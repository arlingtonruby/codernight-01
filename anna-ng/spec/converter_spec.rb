require './converter'
require './transactions'

describe Converter, '#convert' do 

  it "should return 0 if called with 0" do
    convert = Converter.new()
    convert.convert(0, "USD", "USD").should eq(0)
  end

  it "should return value if same currency" do
    convert = Converter.new()
    convert.convert(20, "USD", "USD").should eq(20)
    convert.convert(20, "AUD", "AUD").should eq(20)
  end

  it "should create rate sheet properly" do
    converter = Converter.new()
    converter.import_rates("inputs/RATES.xml")
    converter.current_rates.length.should eq(6)
  end

  it "should be able to convert from AUD to USD using CAD" do
    converter = Converter.new()
    converter.import_rates("inputs/RATES.xml")
    converter.convert(58.58, "AUD", "USD").should eq(59.57)
    converter.convert(19.68, "AUD", "USD").should eq(20.01)
  end

  it "should bankers round properly" do
    converter = Converter.new()
    converter.bankers_round(20.225).should eq(20.22)
    converter.bankers_round(20.235).should eq(20.24)
  end

end

describe StoreTransactions do

  it "should be import transactions properly" do
    store = StoreTransactions.new()
    store.import("inputs/SAMPLE_TRANS.csv")
    store.transactions[0].store.should eq("Yonkers")
    store.transactions[0].sku.should eq("DM1210")
    store.transactions[0].price.should eq(70.00)
    store.transactions[0].currency.should eq("USD")

    store.transactions[4].store.should eq("Camden")
    store.transactions[4].sku.should eq("DM1182")
    store.transactions[4].price.should eq(54.64)
    store.transactions[4].currency.should eq("USD")
  end

  it "should return 134.22 USD for total of DM1182 " do
    store = StoreTransactions.new()
    store.import("inputs/SAMPLE_TRANS.csv")
    store.gross_total_by_sku("DM1182").should eq(134.22)
  end

  it "should return a transactions for a given sku" do
    store = StoreTransactions.new()
    store.import("inputs/SAMPLE_TRANS.csv")
    trans = store.find_by_sku("DM1210")
    trans.length.should eq(2)
  end

end
