=begin
  
Code Graveyard







    #rate = rates.select {|r| r['from'] == [from] and r['to'] == [to] }

    #rate['conversion']

    from_matches = rates.select { |r| r['from'] == [from] }
    to_matches = rates.select { |r| r['to'] == [to] }

    rate = BigDecimal.new(0)

    from_matches.each do |f|
      # if the 'to' is your 'to', set rate = [conversion]
      # otherwise, pull the next set of rates with 
      # 

      to_matches.each do |t|
        if f['to'] == t['from']

          from_rate = BigDecimal(f['conversion'][0])
          to_rate = BigDecimal(t['conversion'][0])
          #puts from_rate
          #puts to_rate
          rate = from_rate * to_rate

          #puts f, t
          #rate = f['conversion'][0].to_i * t['conversion'][0].to_i
          #puts rate
          next
        end
      end
    end



    converted_amount = amount * rate

    return converted_amount







  # def calculate_rates
  #   xml_rates = parse_xml

  #   conv_rates = {
  #     aud_to_cad: ,
  #     aud_to_eur:
  #     cad_to_aud:
  #     cad_to_usd:


  #   }

  # end




      # If that fails
    # Find an element that matches your from
    # then Find an element that matches your to
    # maybe find all the elements for each and put 
    # them in an array

# find all that have your from
# find all that have your to
# compare the to in each from find to the 
# from in each to find.  If they equal, multiply
# the conversion rate of the from find with the to find



    # Create method that looks through the xml_rates array
    # for an element where the 'from' is from and the 'to'
    # is to, then get the conversion rate



=end