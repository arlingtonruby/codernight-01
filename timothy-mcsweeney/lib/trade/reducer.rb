class Reducer
  attr_accessor :sku, :currency, :rates, :transactions_path

  def initialize(sku, currency)
    @sku = sku
    @currency = currency
    @rates = Nokogiri::XML(File.open(RATES_PATH))
    @transactions_path = TRANS_PATH
  end

  def call
    sum = BigDecimal.new(0)
    File.open(transactions_path).each_with_index do |line, index|
      #skip the header line
      next if index == 0  
      transaction = Transaction.new(line)
      #we only care about the one sku
      next unless transaction.sku == sku
      val = process(transaction)
      sum += round(val)
    end
    sum.to_f
  end

  def process(transaction)
    if transaction.currency == currency
      transaction.amount
    else
      convert(transaction)
    end
  end

  def convert(transaction)
    rate = rates.xpath("//rate[from = '#{transaction.currency}' and to = '#{currency}']")
    if rate.any?
      transaction = apply_conversion(transaction, rate.first)
      transaction.amount
    else
      rate = rates.xpath("//rate[from = '#{transaction.currency}']").first
      transaction = apply_conversion(transaction, rate)
      convert(transaction)
    end
  end

  def apply_conversion(transaction, xml)
    rate = Rate.new(xml)
    transaction.currency = rate.to
    transaction.amount =  transaction.amount * rate.conversion
    transaction
  end

  def round(num)
    BigDecimal.new(num).round(2, BigDecimal::ROUND_HALF_EVEN)
  end
end
