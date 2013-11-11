# Just get it working
# not working...

require 'csv'
require 'nokogiri'

# scrape xml doc for rates, store in hashes, and return in an array
class Rates
  attr_accessor :file
  attr_reader :list

  def initialize(file)
    @file = Nokogiri::XML(File.read(file))
    @list = []
    process_rates
  end

  private

  def process_rates
    file.xpath('//rate').each do |rate|
      list << {
        from: rate.xpath('from').text.downcase.to_sym,
        to: rate.xpath('to').text.downcase.to_sym,
        conversion: rate.xpath('conversion').text.to_f
      }
    end
  end

end

# Convert amount from csv into integer and symbol
class Price
  attr_accessor :amount, :currency

  def initialize(amount, currency)
    @amount = amount.to_f
    @currency = currency.downcase.to_sym
  end
end

# process csv of sales
class Sales
  attr_reader :list

  def initialize(file, item)
    @list = []
    collect_sales(file, item)
  end

  private

  def collect_sales(file, item)
    CSV.foreach(file, { headers: true, header_converters: :symbol }) do |row|
      list << Price.new(*row[:amount].split(' '))
    end
  end

end

class PuzzleProcessor
  attr_reader :sales, :rates, :currency

  def initialize(sales, rates, currency)
    @sales = sales.list # Array of sales as Price's
    @rates = rates.list # Array of hashed rates
    @currency = currency.downcase.to_sym
  end

  def sum_sales
    final = []
    sales.each do |price|
      final << convert_currency(price)
    end
    final.reduce(:+).round(2)
  end

  private

  def convert_currency(price)
    price.currency == currency ? price.amount : convert(price)
  end

  def convert(price)
    # idea is to pass in price object, convert to next stage
    # call to_usd(with_new_price_state) until currency == usd
    #
    # Meanwhile... blech...
    # amount of aud * aud to cad conversion
    # amount of cad * cad to usd
    hash = rates.select do |rate|
      rate[:from] == :aud && rate[:to] == :cad
    end.first
    price.amount = hash[:conversion] * price.amount
    price.currency = hash[:to]

    hash = rates.select do |rate|
      rate[:from] == :cad && rate[:to] == :usd
    end.first
    price.amount = hash[:conversion] * price.amount
    price.currency = hash[:to]

    # so this is wrong..
    return price.amount
  end

end

sales = Sales.new('SAMPLE_TRANS.csv', "DM1182")
rates = Rates.new('SAMPLE_RATES.xml')
processor = PuzzleProcessor.new(sales, rates, "usd")

puts "Final answer should be: 134.22"
puts "Final Answer: " + "#{processor.sum_sales}"
