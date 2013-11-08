require 'test/unit'
require_relative '../rate_calculator'

class RateCalculatorTest < Test::Unit::TestCase
  setup do
    @rates = [{:from => 'CAD', :to => 'GBP', :conversion => '0.5942'},
              {:from => 'AUD', :to => 'CAD', :conversion => '0.9890'},
              {:from => 'GBP', :to => 'USD', :conversion => '1.6095'},
              {:from => 'GBP', :to => 'SGD', :conversion => '2.0040'}]
    @calculator = RateCalculator.new(@rates)
  end

  test "first get a map of all the known rates and their inverse" do
    assert_equal(["CAD", "GBP", "AUD", "USD", "SGD"],@calculator.rate_map.keys)
  end

  test "if the rate is known it should be returned" do
    assert_equal(0.5942, @calculator.get_known_rate(:from => 'CAD', :to => 'GBP') )
  end

  test "should return true if rate map exists" do
    assert @calculator.rate_map_exists?(:from => 'AUD', :to => 'CAD')
  end

  test "should get the known rate" do
    assert_equal(0.5942, @calculator.get_known_rate(:from => 'CAD', :to => 'GBP'))
  end

  test "should exit if hit base condition" do
    assert_equal(0.9890, @calculator.rate(:from => 'AUD', :to => 'CAD'))
  end

  test "can get a rate recursively" do
    assert_equal(0.5876638, @calculator.rate(:from => 'AUD', :to => 'GBP'))
  end

  test "can get a rate recursively more than one hop" do
    assert_equal(0.9458448860999998, @calculator.rate(:from => 'AUD', :to => 'USD'))
  end

end
