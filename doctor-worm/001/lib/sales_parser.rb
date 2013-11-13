require 'csv'
require 'sales'

class SalesParser
  attr_reader :input
  attr_reader :output

  def initialize(input)
    @input = load_csv(input)
    @output = objectify!(@input)
  end

  private

  def load_csv(input)
    CSV.read(input)
  end

  def objectify!(input)
    input.shift
    @output = input.map do |datum|
      Sales.new(store: datum[0], sku: datum[1], amount: datum[2])
    end
  end
end
