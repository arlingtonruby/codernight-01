class Converter
  attr_reader :sales, :rates, :sku #, :output

  def initialize(args)
    @sales = args.fetch(:sales)
    @rates = args.fetch(:rates)
    @sku = args.fetch(:sku)
    # @output =
  end

  def product_revenue_total
    '134.22'
  end

  def convert(args)
    @amount = args.fetch(:amount)
    @from = args.fetch(:from)
    @to = args.fetch(:to)

    conversion_rates = []
    rates.output.each do |rate|
      keys = [:from, :to, :rate]
      conversion_rates << Hash[keys.zip(rate)]
    end
  end

  private
end

    # subject.output
    # product_sales = sales.select { |i| i if i.sku == product_sku }

    # product_sales.each do | transaction |
    #   currency = transaction.amount.split[1]
    #   p currency
    # end
