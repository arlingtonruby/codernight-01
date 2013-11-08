require 'test/unit'
require_relative '../report'

class ReportTest < Test::Unit::TestCase

  setup do
    @report = Report.new(:transaction_data => File.read('test/TRANSACTIONS.csv'), :conversion_table => File.read("test/conversion_table.xml"))
  end

  test "a report with a data file with 5 transactions should parse 5 transactions" do
    assert_equal(5, @report.transactions.size)
  end

  test "report should report total of 134.22 for DM1182" do
    assert_equal(134.22, @report.total_for('DM1182'))
  end
end

class ReportTest::TransactionTest < Test::Unit::TestCase

  setup do
    @trans = Report::Transaction.new({'sku' => 'DM1182', 'amount' => '19.68 AUD'}, CurrencyConverter.new(File.read("test/conversion_table.xml")))
  end

  test "a transaction amount should have only the numeric portion of the amount key" do
    assert_equal(19.68, @trans.amount)
  end

  test "a transaction should have a currency" do
    assert_equal('AUD', @trans.currency)
  end

  test "a transaction should return an amount converted to the currency requested" do
    assert_equal(20.01, @trans.amount_in('USD'))
  end

end
