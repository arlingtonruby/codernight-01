module InternationalTrade
  class ExchangeRate
    attr_reader :rate, :source, :target

    def initialize(params)
      @rate   = params[:rate]
      @source = params[:source]
      @target = params[:target]
    end

    def ==(other)
      [:rate, :source, :target].map do |sym|
        self.send(sym) == other.send(sym)
      end.all?
    end
  end
end
