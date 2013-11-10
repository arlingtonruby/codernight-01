require 'international_trade/models/monetary_amount'
require 'international_trade/util/bankers_rounder'

module InternationalTrade
  class SimpleMonetaryConversion
    attr_reader :exchange_rate, :rounder

    def initialize(exchange_rate, rounder)
      @exchange_rate = exchange_rate
      @rounder       = rounder || Util::BankersRounder.new
    end

    def perform(monetary_amount)
      Models::MonetaryAmount.new({
                                   amount: rounded_amount(monetary_amount),
                                   currency: exchange_rate.target_currency
                                 })
    end

    def rounded_amount(monetary_amount)
      rounder.round(unrounded_amount(monetary_amount))
    end

    def unrounded_amount(monetary_amount)
      monetary_amount.amount.send(conversion_operation(monetary_amount), exchange_rate.rate)
    end

    def conversion_operation(monetary_amount)
      if monetary_amount.currency == exchange_rate.source_currency
        :*
      else
        :/
      end
    end
  end
end
