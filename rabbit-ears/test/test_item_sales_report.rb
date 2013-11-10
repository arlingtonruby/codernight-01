require 'helper'

class TestItemSalesReport < Minitest::Should::TestCase

  context "with an ItemSalesReport configured to the example case" do
    setup do
      @reporter = ItemSalesReport.new("files/SAMPLE_RATES.xml","files/SAMPLE_TRANS.csv","DM1182","USD")
    end

    should "equal the example answer" do
      @reporter.process
      assert_equal("134.22", @reporter.answer.to_s)
    end
  end

  context "with an ItemSalesReport configured with a nonexistent rates file" do
    setup do
      @reporter = ItemSalesReport.new("files/MISSING_RATES.xml","files/SAMPLE_TRANS.csv","DM1182","USD")
    end

    should "throw an exception indicating the file is missing" do
      assert_raises(RuntimeError, "File 'files/MISSING_RATES.xml' doesn't exist.") do
        @reporter.process
      end
    end
  end

  context "with an ItemSalesReport configured with a nonexistent transactions file" do
    setup do
      @reporter = ItemSalesReport.new("files/SAMPLE_RATES.xml","files/MISSING_TRANS.csv","DM1182","USD")
    end

    should "throw an exception indicating the file is missing" do
      assert_raises(RuntimeError, "File 'files/MISSING_TRANS.xml' doesn't exist.") do
        @reporter.process
      end
    end
  end

end