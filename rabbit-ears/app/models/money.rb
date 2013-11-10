# Holds a BigDecimal with the value and a code with the ISO 4217
# currency code for this value.  Uses the CurrencyConverter singleton
# to give you its value in different ISO 4217 currency codes.
#
# this class is intentionally designed as immutable.
class Money
  attr_reader :value, :code

  # pass a string in the form of "43.25 USD"
  def initialize(amount)
    input = amount.split(" ")
    @value = BigDecimal.new(input[0])
    @code = input[1]
  end

  def value_in(new_code)
    return @value if new_code == code
    CurrencyConverter.instance.convert(@value, @code, new_code)
  end

end