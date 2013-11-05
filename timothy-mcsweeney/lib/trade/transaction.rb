class Transaction
  attr_accessor :store, :sku, :amount, :currency

  def initialize(row)
    @store, @sku, @amount, @currency = parse_transaction(row)
  end

  private

  def parse_transaction(row)
    split_row = row.split(",")
    raise "Unusual Transaction" unless split_row.size == 3
    store = split_row[0]
    sku = split_row[1]
    amount, currency = parse_currency(split_row[2])
    return store, sku, amount, currency
  end

  def parse_currency(amount_and_currency)
    split = amount_and_currency.split(" ")
    amount = BigDecimal.new(split[0])
    currency = split[1]
    return amount, currency
  end
end
