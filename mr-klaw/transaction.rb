require 'bigdecimal'
require_relative 'currency_converter'

class Transaction
  attr_reader :store, :sku, :amount, :currency

  def self.create(store, sku, amount)
    (@transactions ||= []) << new(store, sku, amount)
  end

  def self.total_for_sku(sku, currency)
    @transactions.select {|t| t.sku ==  sku}.inject(BigDecimal.new(0)) do |sum, transaction|
      sum + CurrencyConverter.instance.convert(transaction.amount, transaction.currency, currency)
    end
  end

  def initialize(store, sku, amount)
    @store = store
    @sku = sku
    amount_str, @currency = amount.split(' ')
    @amount = BigDecimal.new(amount_str)
    if store == nil or sku == nil or @amount == nil or @currency == nil
      puts "Store = #{store}\nSKU = #{sku}\nAmount = #{@amount.to_s('F')}\nCurrency = #{@currency}"
    end
  end
end
