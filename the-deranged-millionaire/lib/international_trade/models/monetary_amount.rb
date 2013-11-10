module InternationalTrade
  class MonetaryAmount
    attr_reader :amount, :currency

    def initialize(params)
      @amount   = params[:amount]
      @currency = params[:currency]
    end
  end
end
