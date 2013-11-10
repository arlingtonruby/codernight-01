class ItemSalesReport
  attr_reader :rates_file, :transactions_file, :sku, :currency_code, :answer

  # typical convention is to create the report with everything necessary
  # to call 'process' next.
  def initialize(rates_file, transactions_file, sku, currency_code)
    @rates_file = rates_file
    @transactions_file = transactions_file
    @sku = sku
    @currency_code = currency_code
  end

  # convention is to handle the entire report, from queries to emails, to
  # file creation here.  This is supposed to be an orchestration method -
  # it does no heavy lifting of its own, it just orchestrates data flowing
  # through other objects doing the processing.  As such, we generally
  # violate method-length limited in this method in order to show the
  # orchestration of the business process clearly and in one spot.
  def process
    App.logger.info "Processing Item Sales Report"

    # confirm we have what we need
    confirm_rates_file
    confirm_transactions_file

    # load the conversion rates
    rates = CurrencyXmlFileParser.parse(rates_file)
    CurrencyConverter.instance.set_rates(rates)

    # load the transactions
    file_size = File.readlines(transactions_file).count
    progressbar = ProgressBar.create(:title => "Parsing Transactions CSV",
                                     :total => file_size)
    transactions = TransactionCsvFileParser.parse(transactions_file) do
      progressbar.increment
    end
    progressbar.finish

    transaction_store = TransactionStore.new(transactions)

    # Select our report dataset
    sku_transactions = transaction_store.find_by_sku(sku)

    # do the math
    @answer = sum_in_currency(sku_transactions, currency_code)

    # report the answer
    # puts @answer.to_s
  end



  def sum_in_currency(transactions, currency_code)
    transactions.reduce(0) do |value, transaction|
      value + transaction[:amount].value_in(currency_code)
    end
  end

  private

  def confirm_rates_file
    unless File.exists?(rates_file)
      message = "File '#{rates_file}' doesn't exist."
      App.logger.error message
      raise message
    end
  end

  def confirm_transactions_file
    unless File.exists?(transactions_file)
      message = "FIle '#{transactions_file}' doesn't exist."
      App.logger.error message
      raise message
    end
  end
end