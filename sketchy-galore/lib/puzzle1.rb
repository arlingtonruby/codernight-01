require 'nokogiri'
require 'open-uri'
require 'active_support/core_ext/hash/conversions'

require 'csv'
require 'pry'

class Puzzle1 



#put the csv file into a hash and then find the DM1182s
  def load_amounts

      csv = CSV.open('/Users/allisonsheren/projects/coder_night/lib/SAMPLE_TRANS.csv', :headers => true,  
                                                                                      :header_converters => :symbol)
      skus = {}
      csv.each do |row| #http://technicalpickles.com/posts/parsing-csv-with-ruby/
        skus[row[:sku]] ||= Array.new #this line initialized the array as an empty array
        skus[row[:sku]] << row[:amount] #so this pushes the amount into the array of amounts that cooresponds to the sku. Key is sku
        #and it has an array of amounts
      end

      skus
         
  end

    currencies
  end

  def rates
    Hash.from_xml(open('/Users/allisonsheren/projects/coder_night/lib/SAMPLE_RATES.xml').read) ["rates"] ["rate"]
  end #calling from_xml on the Hash class, which returns a hash. so then we open the xml doc and then it parses it based on rates rate notations on the xml doc
  #dig down those two elements deep and return a hash with all that information

  def convert_amount (from, to)  #get to the point where I can print out the specific rate 
    #based on converting directly from one thing to another
    rate.each  
      break 
    end

    #look through the list of froms and find the from currency you're looking for. then look through the list of to's
    #to see if the to exists. if it does, apply the rate. If not, look until you find the correct to and then determine
    #the from-to path and apply whatever conversion rates are necessary
  end

  def item #this will be specifically converting everything into USDs
  # USD_amount = []
    re = /(\ USD\z)/
    string != "USD"
    re.match(string)
      # finds the amounts that aren't USD
    else
       puts @amount 
    end
    USD_amount << @amount #puts all the amounts (which are in USD) into an array
  end

  def total_sales 
    item.reduce(:+)
  end
end

puzzle = Puzzle1.new
puts puzzle.load_amounts["DM1182"] 
puts puzzle.rates

#puzzle.item 
#puzzle.total_sales