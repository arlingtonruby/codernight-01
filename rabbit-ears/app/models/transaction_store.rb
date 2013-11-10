# This class represents the 'Store' concept from Eric Evan's
# "Domain Driven Design".  In this version of the app we are
# simply getting data from someplace and holding it in memory,
# but a future version could get it from a web service or a
# database.  Our 'finder' methods in this class abstract that
# from the reporting logic.
class TransactionStore
  attr_reader :transactions

  def initialize(transactions)
    @transactions = transactions
  end

  def find_by_sku(sku)
    @transactions.select do |transaction|
      transaction[:sku] == sku
    end
  end

end