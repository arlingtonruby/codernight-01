class Rate
  attr_accessor :from, :to, :conversion

  def initialize(xml)
    @from, @to, @conversion = parse_rate(xml)
  end

  private

  def parse_rate(xml)
    from = extract(xml, "from")
    to = extract(xml, "to")
    conversion = BigDecimal.new(extract(xml, "conversion"))
    return from, to, conversion
  end

  def extract(xml, key)
    xml.search(key).first.content
  end
end
