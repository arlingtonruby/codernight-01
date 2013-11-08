require_relative 'report'

report = Report.new(:transaction_data => File.read('TRANS.csv'), :conversion_table => File.read('RATES.xml'))
open("output.txt", "w") {|f| f.puts report.total_for('DM1182')}


