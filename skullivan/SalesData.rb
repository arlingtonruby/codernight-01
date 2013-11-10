require 'singleton'
require 'csv'

# Singleton used to stash sales data and do some simple record fetching.
# No math / business logic in this class please.
class SalesData
  include Singleton

  # load the singleton with data.
  def initialize(file = 'TRANS.csv')
    @data = Array.new
    CSV.foreach(file) do |row|
      @data << row
    end
  end

  # return all the records that have the requested product code.
  def fetch(product_code)
    #puts "Fetching product code #{product_code}."
    sales_data = Array.new(@data)
    sales_data.keep_if { |a| a[1] == product_code }
    return sales_data
  end
  
end
