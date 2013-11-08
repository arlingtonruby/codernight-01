class BankerRound

  def initialize(number, precision=2)
    @number = number
    @significance = 10**precision
    @precision = precision
  end

  def round
    "#{rounded_whole_portion}.#{rounded_decimal_portion}".to_f 
  end

  def rounded_whole_portion
    rounded_digits.to_f/@significance
  end

  def rounded_decimal_portion
    rounded_digits.to_s[rounded_whole_portion.to_s.length..rounded_digits.to_s.length-1]
  end

  def rounded_digits
    if(last_digit_is_5 and second_to_last_digit_is_odd) or (last_digit_is_greater_than_5)
      rounded_up_digits
    else
      untouched_digits
    end
  end

  def untouched_digits
    significant_digits.to_s[0..significant_digits.to_s.length-2]
  end

  def rounded_up_digits
    "#{significant_digits.to_s[0..significant_digits.to_s.length-3]}#{second_to_last_digit.to_i+1}"
  end

  def last_digit_is_5
    last_digit == '5'
  end

  def last_digit_is_greater_than_5
    last_digit.to_i > 5
  end

  def last_digit
    significant_digits.to_s[significant_digits.to_s.length-1]
  end

  def second_to_last_digit_is_odd
    !second_to_last_digit_is_even
  end

  def second_to_last_digit_is_even
    (second_to_last_digit.to_i % 2) == 0
  end

  def second_to_last_digit
    n_to_last_digit(2)
  end

  def n_to_last_digit(n)
    significant_digits.to_s[significant_digits.to_s.length-n]
  end

  def significant_digits
    @significant_digits = (@number * 10**(@precision+1)).truncate # it was truncate not round
  end

end
