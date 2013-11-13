# would use a struct, but don't know how to test

class Sales
  attr_accessor :store, :sku, :amount

  def initialize(args)
    @store  = args.fetch(:store)
    @sku    = args.fetch(:sku)
    @amount = args.fetch(:amount)
  end
end
