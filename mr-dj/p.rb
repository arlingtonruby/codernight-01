require 'open-uri'
require 'bigdecimal'
require 'minitest/spec'
require 'minitest/autorun'
require 'active_support/core_ext/hash/conversions'
require 'csv'
require 'pry'

class Rate
  attr_reader :rates
  def initialize
    @rates = Hash.from_xml(open("sample-rates.xml").read)["rates"]["rate"]
  end

  def direct_rate(from, to)
    v = rates.find {|r| r["from"] == from && r["to"] == to }
    v ?  v['conversion'].to_f : nil
  end

  def conversion_rate(from, to)
    # Return immediately if from and to are the same
    return 1 if (from == to)

    # Return immediately if a direct mapping exists.
    return direct_rate(from, to) if direct_rate(from, to)

    rates.select {|rate| rate["from"]==to}.each do |rate|
      # TODO: This only looks one level deep
      return rate["conversion"].to_f * direct_rate(from, rate["to"])
    end
  end

  def convert(from, to, value)
    value * conversion_rate(from, to)
  end
end

class Amount
  attr_reader :currency, :value
  def initialize(str)
    @currency, @value = parse_amount str
  end

  def parse_amount(str)
    v,c = str.split ' '
    [c, v.to_f]
  end

  def round(number)
    BigDecimal.new(number.to_s)
              .round(2, BigDecimal::ROUND_HALF_EVEN)
              .to_f
  end

  def value_for(new_currency)
    rate = Rate.new
    rate.convert(currency, new_currency, value)
  end

  def +(other)
    new_value = round(self.value_for('USD') + other.value_for('USD'))
    Amount.new("#{new_value} USD")
  end

end

class Transaction
  attr_reader :sales

  def find(sku)
    CSV.read('sample-trans.csv', :headers=>true)
       .find_all { |row| row['sku'] == sku}
       .map{|row| Amount.new row['amount']}
  end
end

# Unit
describe Amount do
  it "1+1=2" do
    result = Amount.new("1 USD") + Amount.new("1 USD")
    assert_equal 2.0, result.value
  end

  it "1 USD + 1 CAD = 2 USD" do
    result = Amount.new("1 USD") + Amount.new("1 CAD")
    assert_equal 2.01, result.value
  end
end

describe Rate do
  it "converts AUD to CAD" do
    rate = Rate.new
    assert_equal rate.conversion_rate('AUD', 'CAD'), 1.0079
  end
  it "converts USD to CAD" do
    rate = Rate.new
    assert_equal rate.conversion_rate('USD', 'AUD'), 0.99892969
  end
end

# Integration
describe Transaction do
  it "finds the sales for DM1182" do
    trans = Transaction.new
    sales = trans.find "DM1182"
    total = sales.inject(:+)
    assert_equal total.value, 134.22
  end
end
