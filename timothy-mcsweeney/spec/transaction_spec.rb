require "spec_helper"

describe Transaction do

  let(:data) { "Yonkers,DM1210,70.00 USD" }

  context "when initialized" do
    it "parses store, sku, amount, and currency from the transaction" do
      transaction = Transaction.new(data)
      expect(transaction.store).to eql("Yonkers")
      expect(transaction.sku).to eql("DM1210")
      expect(transaction.amount).to eql(70.00)
      expect(transaction.currency).to eql("USD")
    end
  end

end