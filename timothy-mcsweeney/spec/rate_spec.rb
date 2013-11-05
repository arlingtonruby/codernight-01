require "spec_helper"

describe Rate do

  let(:xml) { Nokogiri::XML("<rate><from>AUD</from><to>CAD</to><conversion>1.0079</conversion></rate>") }

  context "when initialized" do
    it "parses from, to, and conversion from the rate" do
      rate = Rate.new(xml)
      expect(rate.from).to eql("AUD")
      expect(rate.to).to eql("CAD")
      expect(rate.conversion).to eql(1.0079)
    end
  end

end