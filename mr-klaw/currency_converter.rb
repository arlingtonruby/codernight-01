require 'bigdecimal'
require 'singleton'

class CurrencyConverter
  include Singleton

  def add_rate(source, target, conversion)
    conversion_hash[source][target] = BigDecimal.new(conversion)
    derive_missing_conversions(source, target)
  end

  def convert(amount, source_currency, target_currency)
    return amount if source_currency == target_currency
    (amount * conversion_hash[source_currency][target_currency]).round(2,:banker)
  end

  def display_rates
    conversion_hash.each do |source, target_hash|
      target_hash.each {|target, rate| puts "1 #{source} -> #{rate.to_s('F')} #{target}"}
    end
  end

  private
  def conversion_hash
    @conversion_hash ||= Hash.new { |hash, key| hash[key] = {} }
  end

  def derive_missing_conversions(new_source, new_target)
    conversion_hash.each do |source, target_hash|
      if target_hash.keys.include?(new_source) and target_hash[new_target].nil? and source != new_target
        target_hash[new_target] = conversion_hash[new_source][new_target] * target_hash[new_source]
      end
    end
    conversion_hash[new_target].each do |target, conversion|
      if conversion_hash[new_source][target].nil? and new_source != target
        conversion_hash[new_source][target] = conversion_hash[new_source][new_target] * conversion
      end
    end
  end
end
