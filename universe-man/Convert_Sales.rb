require 'bigdecimal'
require 'csv'
require 'ostruct'
require 'rexml/document'
include REXML
require './lib/rate'
include RateStuff
require './lib/sales'

class ConversionRate < Rate 
end

class SaleTotals < Sales
end

puts "Enter CSV File"
sales_data = gets.chomp
puts "Enter XML File"
rates_xml = gets.chomp

xmlfile = File.new(rates_xml)
xmldoc = Document.new(xmlfile)

ConversionRate.new(xmldoc)
ConversionRate.compute_exchange_rates
exchange_rates = ConversionRate.exchange_rates

sales = CSV.open sales_data
SaleTotals.new(sales)
SaleTotals.convert_to_dollars(exchange_rates)

puts SaleTotals.total_sales
