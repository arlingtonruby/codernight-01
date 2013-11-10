module RateStuff

  def mult(a, b)
      x = BigDecimal("0") + a.to_f
      y = BigDecimal("0") + b.to_f
      x * y
  end

  class Rate

    @@exchange_rates = { "USD" => 1 }
    def self.exchange_rates
      @@exchange_rates
    end

    @@struct_rates = []
    def self.struct_rates
      @@struct_rates
    end

    def initialize(xml_data)
      xml_data.elements.each("rates/rate") do |raw_rate|
      @@struct_rates << format(raw_rate)
      end
    end

    def self.compute_exchange_rates
      @@struct_rates.each do |rate|
        (@@exchange_rates[rate.from] = rate.conversion) && (@@struct_rates.delete(rate)) if rate.to == "USD"
        @@struct_rates.delete(rate) if rate.from == "USD"
      end

      while !@@struct_rates.empty?
        @@struct_rates.each do |rate|
          if (@@exchange_rates.keys.include?(rate.to)) && !(@@exchange_rates.keys.include?(rate.from))
            con_rate = mult(@@exchange_rates[rate.to], rate.conversion)
            @@exchange_rates[rate.from] = con_rate
            @@struct_rates.delete(rate)
          else @@exchange_rates.keys.include?(rate.from)
            @@struct_rates.delete(rate)
          end
        end
      end
    end

    def format(xml_element)
      t = OpenStruct.new
      t.from = xml_element.elements["from"].text
      t.to = xml_element.elements["to"].text
      t.conversion = xml_element.elements["conversion"].text.to_f
      return t
    end

  end
end
