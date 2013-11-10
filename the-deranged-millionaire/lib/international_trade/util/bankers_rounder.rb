require 'bigdecimal'

module InternationalTrade
  module Util
    class BankersRounder
      def initialize
        # don't like that I'm modifying BigDecimal.mode for everything
        # else; need to find a way to inspect the mode so I can reset
        # after doing my rounding
        BigDecimal.mode(BigDecimal::ROUND_HALF_EVEN)
      end

      def round(n)
        BigDecimal.new(n.to_s).round
      end
    end
  end
end
