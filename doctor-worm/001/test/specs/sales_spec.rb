# probably don't have to test this
# consider it a sanity check?

require 'test/test_helper'

describe Sales do
  before do
    @sales = Sales.new(store: 'ABC', sku: '123', amount: '1 USD')
  end

  describe 'class signature' do
    it 'has getter and setter for data' do
      @sales.must_respond_to :store
      @sales.must_respond_to :sku
      @sales.must_respond_to :amount
    end
  end

  describe 'given an initial hash' do
    it 'contains the correct data' do
      @sales.store.must_equal 'ABC'
      @sales.sku.must_equal '123'
      @sales.amount.must_equal '1 USD'
    end
  end
end
