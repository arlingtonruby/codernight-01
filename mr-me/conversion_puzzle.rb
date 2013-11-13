require 'pp'
require 'bigdecimal'
require 'xmlsimple'

class Conversion

  def parse_xml
    XmlSimple.xml_in('rates.xml', { 'KeyAttr' => 'name' })['rate']
  end

  def convert( convert_from, convert_to, amount )

    rates = parse_xml

    from = convert_from
    to = convert_to

    conversion_rates = []
    final_rate = BigDecimal.new( 0 )
    path = []
    step = 0

    while final_rate == 0

      path[step] = rates.select { |r| r['to'] == [to] }

      if path[step][0]['from'] == [from]
        path.each do |step|
          conversion_rates << BigDecimal.new( path[step][0]['conversion'][0] ) # Make bigdecimal
        end
        final_rate = conversion_rates.inject(:*)
        next
        # Done, get the conversion_rate by multiplying all the rates
      end

      to = path[step][0]['from'][0]

      step += 1

    end

    puts final_rate

  end

end

c = Conversion.new
puts c.convert('AUD', 'USD', 5)
