# Given a CSV file, parses it into an array of transactions.
# It uses the CSV parser built into ActiveSupport.
#
# When we converted to JRuby with the custom converter,
# parsing the larger file started to take some time. To
# indicate this, #parse now takes an optional block that gets
# called for each row. (we use this for ProgressBar gem callback).

class TransactionCsvFileParser
  require 'csv'

  # Injecting a custom converter to turn the amount column into an
  # instance of our Money class.
  CSV::Converters[:amount] = lambda{ |field, field_info|
      field_info[:header] == :amount ? Money.new(field) : field
  }

  def self.parse(file)
    transactions = []
    CSV.foreach(file, {:headers => true,
                       :header_converters => :symbol,
                       :converters => [:all, :amount]}) do |row|
      transactions << row.to_hash
      yield row if block_given?
    end
    transactions
  end
end
