require_relative 'currency_converter'
require_relative 'transaction'
require 'csv'
require 'rexml/document'

RATE_FIELDS = %W(from to conversion)
REXML::Document.new(File.open('RATES.xml')).elements.each('//rates/rate') do |rate|
  CurrencyConverter.instance.add_rate(*RATE_FIELDS.map { |field| rate.elements[field].text})
end

TRANSACTION_COLS = %W(store sku amount)
CSV.foreach('TRANS.csv', :headers => true) do |transaction|
  Transaction.create(*TRANSACTION_COLS.map { |col| transaction[col]})
end

puts Transaction.total_for_sku('DM1182', 'USD').to_s('F')
