require 'nokogiri'
require 'rates'

class RatesParser
  attr_reader :input
  attr_reader :output

  def initialize(input)
    @input = load_xml(input)
    @output = objectify!(@input)
  end

  private

  def load_xml(input)
    File.open(input) do |f|
      Nokogiri::XML(f).search('rate').map(&:text).map(&:split)
    end
  end

  def objectify!(input)
    @output = input.map do |datum|
      Rates.new(from: datum[0], to: datum[1], rate: datum[2])
    end
  end
end
