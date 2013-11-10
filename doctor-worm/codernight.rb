#!/usr/bin/env ruby

# gc wesley - Coder's Night #1
# Parse a CSV file named Trans.csv
# to returns an array of hashes
# that consists of all values = DM1182
def csv(trans)
  File.open("trans.csv") do|f|
    columns = f.readline.chomp.split(',')

    table = []
    until f.eof?
      row = f.readline.chomp.split(',')
      row = columns.zip(row).flatten
      table << Hash[*row]
    end

    return columns, table
  end
end

# Print a sorted list from trans.csv file.
columns, trans = csv(ARGV[0])

# Sort by store name
trans.sort_by! do|a|
  if a.values_at(1) == "DM1182"
  		a.values_at(1,2,0).each{|a| p a}
  end
end

# Determine column widths
column_widths = {}
columns.each do|c|
  column_widths[c] = [ c.length, *trans.map{|g| g[c].length } ].max
end

# Make the format string
format = columns.map{|c| "%-#{column_widths[c]}s" }.join(' | ')

# Print the table
puts format % columns
puts format.tr(' |', '-+') % column_widths.values.map{|v| '-'*v }

trans.each do |g|
  puts format % columns.map{|c| g[c] }
end

# To Do:
# Derive AUD/USD, USD/AUD, USD/EUR and EUR/USD rates
# and calculate missing rates.  Convert all rates to USD and sum values
# print final array
