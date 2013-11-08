require_relative 'currency_converter'
require 'csv'

class Report

  def initialize(params={:transaction_data => 'stream of csv data', :conversion_table => 'stream of xml data'})
    @data = params[:transaction_data]
    @currency_converter = CurrencyConverter.new(params[:conversion_table])
  end

  def total_for(sku, currency='USD')
    BankerRound.new(transactions.inject(0.00) {|sum, transaction| sum + (transaction.for_sku?(sku) ? transaction.amount_in(currency) : 0.00)}).round
  end

  def transactions
    CSV.parse(@data, :headers => true).map {|row| Transaction.new(row, @currency_converter)} 
  end

  class Transaction
    attr_reader :currency_converter
    def initialize(row, currency_converter)
      @row = row
      @currency_converter = currency_converter
    end

    def for_sku?(the_sku)
      @row['sku'] == the_sku
    end

    def amount
      @row['amount'].to_f
    end

    def currency
      @row['amount'].to_s.upcase[/[A-Z]+/]
    end

    def amount_in(to_currency)
      @currency_converter.convert({:from => currency, :to => to_currency, :amount => amount}) 
    end

    def sku
      @row['sku']
    end

  end

end
