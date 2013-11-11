require 'minitest/autorun'
require 'csv'
require 'open-uri'
require 'nokogiri'
require 'bigdecimal'

class Minitestable < Minitest::Unit::TestCase
end

SAMPLE_TRANS = "https://puzzlenode.s3.amazonaws.com/attachments/3/SAMPLE_TRANS.csv"
SAMPLE_RATES = "https://puzzlenode.s3.amazonaws.com/attachments/4/SAMPLE_RATES.xml"
RATES = "https://puzzlenode.s3.amazonaws.com/attachments/2/RATES.xml"
TRANS = "https://puzzlenode.s3.amazonaws.com/attachments/1/TRANS.csv"

class Rates
	attr_reader :rates

	def initialize(rates_url)
		@rates_xml = Nokogiri::XML(open(rates_url))
		@currencylist = []
		update_currencies(@rates_xml)
	end

  def rates
  	@currencylist
  end

  private

  def update_currencies(xml)
		xml.search('rate').map do |rate|
    	@currencylist << "#{rate.at("from").text} #{rate.at("to").text} #{rate.at("conversion").text.to_f}"
    end
  end
end

class Transactions
	attr_reader :list, :total

	def initialize(trans_url, rates)
		@list = []
		@rates = rates
		read(trans_url)
		@total = 0
	end

	def sum
		@list.each do |item|
			if item.split[1] == "USD"
				@total += item.split[0].to_f
			else
				@total += normalize(item)
			end
		end
	end

	def total
		sum
		BigDecimal.new(@total).round(2,BigDecimal::ROUND_HALF_EVEN)
	end

	def normalize(item)
		@item = item
		@temp = @rates.clone
		@baserate = @temp.select{|list| list.split[1] == "USD"}.first.split[0]
		while @item.split[1] != "USD"
			tempitem = @temp.select{|list| list.split[0] == @item.split[1] }.first
			@item[@item.split[1]] = tempitem.split[1]
			@item[@item.split[0]] = (@item.split[0].to_f * tempitem.split[2].to_f).to_s
			@temp.delete(tempitem)
			@temp.push(tempitem)
		end
		BigDecimal.new(@item.split[0]).round(2,BigDecimal::ROUND_HALF_EVEN)
	end

	private

	def read(url)
		CSV.new(open(url), :headers => :first_row).each do |line|
			if line[1] == "DM1182"
				@list << line[2]
			end
		end
	end
end



class SampleTesting < Minitestable

	def setup
		@conversion_rates = Rates.new(SAMPLE_RATES)
		@transactions = Transactions.new(SAMPLE_TRANS, @conversion_rates.rates)
	end

	def test_single_transaction_download
		assert_includes @transactions.list, "19.68 AUD"
	end

	def test_transaction_download
		assert_equal @transactions.list.sort, ["19.68 AUD", "58.58 AUD", "54.64 USD"].sort
	end

	def test_all_rates_download
		assert_equal @conversion_rates.rates, ["AUD CAD 1.0079", "CAD USD 1.009", "USD CAD 0.9911"]
	end

	def test_sum_in_usd
		assert_equal @transactions.total, 134.22
	end
end

class ForRealzTesting < Minitestable

	def setup
		@conversion_rates = Rates.new(RATES)
		@transactions = Transactions.new(TRANS, @conversion_rates.rates)
	end

	def test_sum_only_usd
		assert_equal @transactions.total, "The total"
	end
end
