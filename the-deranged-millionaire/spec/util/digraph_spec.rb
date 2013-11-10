require 'minitest/autorun'
require 'international_trade/util/digraph'

module InternationalTrade::Util
  describe "Digraph" do
    before do
      Step = Struct.new(:source, :target)

      @steps = [
        Step.new(:usd, :aud),
        Step.new(:aud, :eur),
        Step.new(:eur, :cad)
      ]

      @graph = Digraph.new(@steps)

      @sources = @steps.map(&:source)
      @targets = @steps.map(&:target)
    end

    it "is symmetric" do
      @sources.each do |source|
        @targets.each do |target|
          unless source == target
            @graph.path_from_to(source, target).must_equal @graph.path_from_to(target, source).reverse
          end
        end
      end
    end
  end
end
