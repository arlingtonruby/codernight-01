require 'nokogiri'
require 'international_trade/util/digraph'
require 'international_trade/models/exchange_rate'

module InternationalTrade
  class ExchangeRateDataImport
    attr_reader :path

    def initialize(path = File.join(__FILE__.split('/')[0...-2], 'data/rates.xml'))
      @path = path
    end

    def perform
      Nokogiri.parse(File.read(path)).css('rate').map do |rate_node|
        elements = rate_node.children.select { |c| c.children.count > 0 }
        source = elements[0].text.downcase.to_sym
        target = elements[1].text.downcase.to_sym
        rate = elements[2].text.to_f

        ExchangeRate.new({source: source, target: target, rate: rate})
      end
    end
  end
end
