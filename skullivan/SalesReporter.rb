require_relative 'SalesData'
require_relative 'ConversionData'
require_relative 'CurrencyConverter.rb'

# grab the source data 
# @TODO catch type mismatches, i.e. conversions file must be xml, transactions must be csv, etc.
product_code = ARGV[0] #'DM1182'
target_country_code = ARGV[1] #'USD'
transaction_file = ARGV[2] #'TRANS.csv'
conversions_file = ARGV[3] #'RATES.xml'

# do the business...
converter = CurrencyConverter.new
result = converter.tabulate_and_convert
puts "The answer is... #{result}."
