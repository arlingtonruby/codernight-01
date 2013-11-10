class Sales

  @@store_totals = {}
  def self.store_totals
    @@store_totals
  end

  @@store_totals_in_dollars = {}
  def self.dollar_totals
    @@store_totals_in_dollars
  end

  def initialize(sales)
    sales.each do |row|
      if row[1] == "DM1182"
        sale = row[2].split
        @@store_totals[sale[0]] = sale[1]
      end
    end
  end

  def self.convert_to_dollars(conversion_rates)
    @@store_totals_in_dollars = @@store_totals.map do |sale|
      rate = conversion_rates[sale[1]]
      num =  mult(rate, sale[0])
      sale[0] = num.to_f.round(2)
    end
  end

  def self.total_sales
    @@store_totals_in_dollars.inject(:+)
  end

end
