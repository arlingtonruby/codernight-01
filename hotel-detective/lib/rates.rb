# would use a struct, but don't know how to test

class Rates
  attr_accessor :from, :to, :rate

  def initialize(args)
    @from = args.fetch(:from)
    @to = args.fetch(:to)
    @rate = args.fetch(:rate)
  end
end
