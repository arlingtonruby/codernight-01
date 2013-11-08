require 'test/unit'

require_relative '../banker_round.rb'

class BakerRoundText < Test::Unit::TestCase
  setup do
    @banker_round = BankerRound.new(2.52523)
  end
  test "a banker_round should take a number" do
    assert(@banker_round)
  end

  test "a banker_round should first get an integer with three decimals as integers" do
    assert_equal(2525, @banker_round.significant_digits)
  end
  test "then it should test if the last digit is 5" do
    assert(@banker_round.last_digit_is_5, "expected the last digit to be 5")
  end

  test "then it should test if the second to last digit is even" do
    assert(@banker_round.second_to_last_digit_is_even, "expected this to be even")
  end

  test "if the last number is 5 and the second to last number is even then it should return the number unrounded" do
    assert_equal(2.52, @banker_round.round)
  end

  test "if the last number is less than 5 then it should return the number unrounded" do
    br = BankerRound.new(2.2222)
    assert_equal(2.22, br.round)
  end

  test "if the last digit is greater than 5 it should return the number rounded up one" do
    br = BankerRound.new(2.336324)
    assert_equal(2.34, br.round)
  end

  test "if the last number is 5 and the second to last number is odd then it should return the number rounded up one" do
    br = BankerRound.new(2.335324)
    assert_equal(2.34, br.round)
  end

  test "it should find the second to last digit" do
    br = BankerRound.new(23.5) #23500
    assert_equal('0', br.second_to_last_digit)
  end


  test "it should not round a number with only one decimal" do
    br = BankerRound.new(23.5)
    assert_equal(23.5, br.round)
  end

  test "it should not round a number with no decimals" do
    br = BankerRound.new(23)
    assert_equal(23.0, br.round)
  end

  test "it should be able to take more decimal precision" do
    br = BankerRound.new(25.1223456, 4)
    assert_equal(25.1223, br.round)
  end

  test "it should be able to work with long decimals" do
    br = BankerRound.new(0.90675456, 4)
    assert_equal(90675, br.significant_digits)
  end

  test "it should be able to round with long decimals" do
    br = BankerRound.new(0.5876638, 4)
    assert_equal(0.5877, br.round)
  end

  test "it can round even long decimals correctly" do
    br = BankerRound.new(0.945844886099999, 4)
    assert_equal(0.9458, br.round)
  end

end
