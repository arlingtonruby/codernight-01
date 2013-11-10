#!/usr/bin/ruby

require 'csv'
require 'nokogiri'
require './round_half_even'

FILE_TRANS = "TRANS.csv"
FILE_RATES = "RATES.xml"
FILE_OUTPUT = "OUTPUT.txt"

puts "Enter an item: "
item = gets.chomp

def read_xml(file_name) 
  file_handle = open(file_name)
  xml = Nokogiri::XML(file_handle)
  rates = xml.search("rate")
  return rates
end

def get_conversion(currency, amount, old_from="none", old_to="none")
  old_from = currency
  rates = read_xml(FILE_RATES)
  return amount if currency == "USD" 
  
  rates.each do |rate|
    new_currency = rate.at("to").content
    old_to = new_currency
      conversion = rate.at("conversion").content.to_f
      new_amount = (amount * conversion).round_half_even
      #puts "FROM #{rate.at("from").content} TO #{rate.at("to").content} old_from #{old_from} old_to #{old_to}"
    if rate.at("from").content == currency && new_currency != old_to && currency != old_from
      return get_conversion(new_currency, new_amount, old_from, old_to)
    elsif rate.at("to").content == "USD"
      #puts "^^ #{rate.content}"
      return new_amount
#    else
#      return get_conversion(new_currency, new_amount, old_from, old_to)
    end
  end


#  rates.each do |rate|
#    if rate.at("from").content == currency && rate.at("to").content == "USD" 
#      new_currency = rate.at("to").content 
#    else
#      new_currency = rate.at("to").content 
#    end
#    puts "#{new_currency}"
#    conversion = rate.at("conversion").content.to_f    
#    new_amount = (amount * conversion).round_half_even

#    if new_currency != "USD" 
#      return get_conversion(new_currency, new_amount, old_currency) 
#    elsif new_currency == "USD" 
#      return new_amount
#    end
#  end

end

def get_total(file_name, item)
  id = 0
  total_amount = 0.0
  
  CSV.foreach(File.path(file_name), :headers => true, :header_converters => :symbol, :converters => :all) do |row|
    id = id + 1
    row[2] = row[2].split
    currency = row[2][1]
    amount = row[2][0].to_f

    if row[1] == item
      total_amount = total_amount + get_conversion(currency, amount)
      total_amount = total_amount.round_half_even
      #puts "#{row[0]} item #{row[1]} amount #{amount} currency #{currency} total_amount #{total_amount}"
    end
    #items[id] = Hash[row.headers[0..-1].zip(row.fields[0..-1])]
  end
  File.open(FILE_OUTPUT, 'w') { |file| file.write(total_amount) }
  return total_amount.round_half_even
  #return items.to_s
end



#puts "Start"
puts data = get_total(FILE_TRANS, item)
#puts "End"
