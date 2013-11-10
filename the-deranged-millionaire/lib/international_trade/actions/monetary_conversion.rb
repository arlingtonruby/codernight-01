require 'interational_trade/actions/simple_monetary_conversion'

module InternationalTrade
  class MonetaryConversion
    attr_reader :exchange_rates, :rounder

    def initialize(exchange_rates, rounder)
      @exchange_rates = exchange_rates
      @rounder        = rounder
    end

    def perform(monetary_amount)
      exchange_rates.reduce(monetary_amount) do |monetary_amount, exchange_rate|
        SimpleMonetaryConversion.new(exchange_rate, rounder).perform(monetary_amount)
      end
    end
  end
end
