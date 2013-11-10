
# closest thing to a business class in the system. runs currency conversions and 
# returns tabulated data based on requested product code.
class CurrencyConverter

  def tabulate_and_convert(product_code = 'DM1182', target_country_code = 'USD')
    puts "Product code is #{product_code} and target country code is #{target_country_code}."
    data = SalesData.instance.fetch(product_code)
    puts "Found #{data.size} sales records matching the product code."
    total_sales = 0;
    data.each do |e|
      currency = e[2]
      converted = convert(currency[0..-5], currency[-3,3], target_country_code)
      puts "Converted value is #{converted}."
      total_sales += converted
    end
    return total_sales
  end

  def convert(value, source_country_code, target_country_code)
    puts ""
    puts "Seeking to convert #{value} from #{source_country_code} to #{target_country_code}."
    rate = ConversionData.instance.get_rate(source_country_code, target_country_code)
    if rate[1] == 0
      # get a rate, any rate, that matches our source.      
      rate = ConversionData.instance.get_single_rate(source_country_code)
      puts "Converted #{source_country_code} to #{rate[0]}."
      convert(value.to_f * rate[1].to_f, rate[0], target_country_code)
    else
      # puts "Got conversion rate #{rate[1]}."
      return value.to_f * rate[1].to_f
    end

  end

end

