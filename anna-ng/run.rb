
require './transactions'

store = StoreTransactions.new()
store.import("inputs/SAMPLE_TRANS.csv")
puts store.gross_total_by_sku("DM1210")
