require 'minitest/autorun'
require 'international_trade/actions/exchange_rate_data_import'

module InternationalTrade
  describe "ExchangeRateDataImport" do
    it "imports the test data correctly" do
      rates = ExchangeRateDataImport.new.perform

      expected_rates = [
        [:aud, :cad, 1.0079],
        [:cad, :usd, 1.0090],
        [:usd, :cad, 0.9911]
      ].map do |source, target, rate|
        ExchangeRate.new({source: source, target: target, rate: rate})
      end

      rates.zip(expected_rates).each do |rate, expected_rate|
        rate.must_equal expected_rate
      end
    end
  end
end
