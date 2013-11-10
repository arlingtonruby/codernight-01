require 'singleton'

# Somewhat controversially, I'll make this a singleton.  I think it
# defines a business intent.  At no point do we need to have multiple
# conversion tables floating around, and this solution wasn't designed
# with that in mind.  Since it wasn't designed with that in mind, I'm
# purposely restricting its use to *not* allow that possibility. If in
# the future we need multiple conversion tables, such as allowing us
# to figure out answers using conversation rates for August 4th vs.
# August 19th, a proper design and tests should be created for that.
#
# That is, the singleton here indicates essential complexity, nor
# accidental conplexity.
class CurrencyConverter
  include Singleton

  attr_reader :rates

  # before we use this, we need to set the rates.
  def set_rates(rates)
    @rates = rates
  end

  # While coding the solution, I found an ambiguity in the requirements.
  # The test data converged on this solution, but the description, talking
  # about 'rounding after each conversion' could easily lead to the other
  # conclusion.
  # The question is, do you figure out the conversion rate by multiplying
  # all the conversion rates together, or do you convert and round at each
  # intermediate step.  When I converted and rounded at each intermediate
  # step, my solution was off by a penny.  When I found the conversion
  # rate first, my solution was correct.  Personally, I'd ask the client
  # which way is correct to get clarification, even though the test data
  # provided direction.
  def convert(amount, from, to)
    (amount * find_rate(from, to)).round(2)
  end


  # Given from and to ISO 4217 Currency Codes, will return a conversion
  # rate. If no direct rate it available, it will use a depth-first search
  # to find the shortest path between codes and compute a compound
  # conversion rate.  It will blow up spectacularly if not path is available.
  def find_rate(from, to)
    path = currency_path(from, to)
    conversion_rate = path.reduce(1) do |rate, conversion|
      (rate * lookup_rate(conversion[0], conversion[1]))
    end
  end

  # Given from and to ISO 4217 Currency Codes, will look up a conversion
  # rate from the data provided via set_rates.  If no direct rate is
  # available, it will return nil.
  def lookup_rate(from, to)
    rate = rates.find { |r| r["from"] == from && r["to"] == to }
    return if rate.nil?
    return rate["conversion"].to_f
  end





  private

  def currency_path(from, to)
    possible_paths = [[to]]
    begin
      possible_paths = deep_search(possible_paths)
      path_elements = possible_paths.find { |p| p.include?(from) }
    end until path_elements
    path_elements.reverse!

    path = []
    (path_elements.count-1).times do |i|
      path << [path_elements[i], path_elements[i+1]]
    end

    path
  end

  def deep_search(inputs)
    outputs = []
    inputs.each do |path|
      conversions_to(path.last).each do |c|
        outputs << ((path.dup) << c["from"])
      end
    end
    outputs
  end

  def conversions_to(to_currency)
    @rates.select { |r| r["to"] == to_currency }
  end

end

