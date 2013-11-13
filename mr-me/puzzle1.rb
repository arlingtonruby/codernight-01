# What is the grand total of sales
# for item DM1182 across all stores in USD currency?

# isolate item DM1182 in CSV file
# apply relevant conversion rate from xml file to get USD
  # --> need to figure out how to call xml file / lines of xml file
# add converted rates together

csv_file = './TRANS.csv'

# note to self:
# this opens CSV file, prints each line (using kitty)
File.open(csv_file).each do |kitty|
  print "This line\'s contents: " + kitty
end

lines = []

File.open(csv_file).each do |kitty|
  line = kitty.split ','
  lines << line
end

require 'ap'
ap lines

require 'csv'
csv_data = CSV.read(csv_file)

require 'xmlsimple'
config = XmlSimple.xml_in('rates.xml', { 'KeyAttr' => 'name'})

# need to isolate conversion rates for:
# EUR to USD
# CAD to USD #included
# AUD to USD

# csv_data = ['store', 'sku', 'amount']

# now what?
# have the conversion rates from xml in a hash
# need to access the hash to get the conversion rates
# then have to apply the conversion rates to the relevant products