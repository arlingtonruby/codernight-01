require 'singleton'
require 'xmlsimple'

# Singleton used to carry and return conversion data.
class ConversionData
  include Singleton

  # load the data.
  def initialize(file = 'RATES.xml')
    @conversion_rates = XmlSimple.xml_in(file)
  end

  # return the target country and conversion rate needed to convert source to target.
  def get_rate(source, target)
    puts "Seeking exchange rate to convert from #{source} to #{target}."
    return rate_and_target = [target, 1] if source == target
    @conversion_rates['rate'].each do |rate|
      if rate["from"][0] == source && rate["to"][0] == target
        puts "Matched!! See: #{rate}."
        rate_and_target = [target, rate["conversion"][0]]
        return rate_and_target
      end
    end
    puts "Could not find a direct conversion from #{source} to #{target}; returning 0."
    return rate_and_target = [target, 0]
  end

  # return the 'first found' target country and conversion rate that exists for this source.
  def get_single_rate(source)
    puts "Seeking any conversion rate from this source; first found will be returned."
    @conversion_rates['rate'].each do |rate|
      if rate["from"][0] == source
        target = rate["to"][0]
        puts "We could convert #{source} to #{target} instead..."
        rate_and_target = [target, rate["conversion"][0]]
        return rate_and_target
      end
    end
  end

end


