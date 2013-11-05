require 'Nokogiri'
require 'bigdecimal'

class Converter
  attr_accessor :conversion_path, :current_rates

  def import_rates(file_name)

    @current_rates = []
    
    rate_sheet = Nokogiri.XML(File.open(file_name, 'r')) do |config|
      config.noblanks
    end
    
    rate_sheet.xpath("rates").children.each do |r|
      @current_rates << ConversionRate.new(r.xpath("conversion").text, r.xpath("from").text, r.xpath("to").text)
    end
    
    @current_rates
  
  end

  def convert(value, from_currency, to_currency)

    return bankers_round(value) if from_currency == to_currency
    
    location = @current_rates.find_index{|i| i.from_currency == from_currency && i.to_currency == to_currency}

    if location
      return bankers_round((value * @current_rates[location].value))
    else   
      location = @current_rates.find_index{|i| i.from_currency == from_currency}
      self.convert((value * @current_rates[location].value), @current_rates[location].to_currency, to_currency)
    end

  end

  def bankers_round(number)
    number = number.to_s if number.class == Float || number.class == Fixnum
    BigDecimal.new(number).round(2, BigDecimal::ROUND_HALF_EVEN).to_f.round(2)
  end


end

class ConversionRate

  attr_accessor :value, :from_currency, :to_currency

  def initialize(value, from_currency, to_currency)
    @value = value.to_f
    @from_currency = from_currency
    @to_currency = to_currency
  end

end
