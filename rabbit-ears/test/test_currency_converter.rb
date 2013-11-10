require 'helper'

class TestItemSalesReport < Minitest::Should::TestCase

  context "with a configured CurrencyConverter" do
    setup do
      rates = [{"from" => "WES",
                "to" => "ESS",
                "conversion" => "1.5"},
               {"from" => "ESS",
                "to" => "NOR",
                "conversion" => "2.0"}]
      CurrencyConverter.instance.set_rates(rates)
    end

    should "lookup a conversion from Westeros to Essos" do
      assert_equal(1.5, CurrencyConverter.instance.lookup_rate("WES", "ESS"))
    end

    should "find a conversion from Westeros to North of the Wall" do
      assert_equal(3.0, CurrencyConverter.instance.find_rate("WES", "NOR"))
    end

  end

end