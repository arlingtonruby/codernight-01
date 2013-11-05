require './converter'

class StoreTransactions

  attr_accessor :transactions

  def import(file_name)
    transaction_array = []
    transaction_file = File.open(file_name, 'r')
    transaction_file.each_line{|t| transaction_array << Transaction.new(t.split(","))}
    transaction_array.delete_at(0)
    @transactions = transaction_array
  end

  def find_by_sku(sku)
    indexes = @transactions.each_index.select{|i| @transactions[i].sku == sku}
    return_transactions = []
    indexes.each {|i| return_transactions << @transactions[i]}
    return_transactions
  end

  def gross_total_by_sku(sku, to_currency = "USD")
    converter = Converter.new()
    converter.import_rates("inputs/RATES.xml")
    gross_total_sum = 0
    all_transactions = find_by_sku(sku)
    all_transactions.each do |t|
      gross_total_sum = converter.bankers_round(gross_total_sum + converter.convert(t.price, t.currency, to_currency))
    end
    gross_total_sum
  end

end

class Transaction

  attr_accessor :store, :sku, :price, :currency

  def initialize(line)
    @store = line[0]
    @sku = line[1]
    temp = line[2].split(" ")
    @price = temp[0].to_f
    @currency = temp[1]
  end

end