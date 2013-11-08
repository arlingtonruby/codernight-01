require_relative 'banker_round'

class RateCalculator

  attr_reader :rate_map

  def initialize(rates)
    @rates = rates
    @rate_map = {}
    init_rate_map
  end

  def init_rate_map
    @rates.each do |row|
      set_rate_map_for(row) 
    end
  end

  def set_rate_map_for(params={:from => 'GBP', :to => 'USD', :conversion => 0.99})
    @rate_map[params[:from]] ||= {}
    @rate_map[params[:from]].merge!({params[:to] => params[:conversion].to_f})
    @rate_map[params[:to]] ||= {}
    @rate_map[params[:to]].merge!({params[:from] => 1.0/params[:conversion].to_f})
  end

  def get_known_rate(params = {:from => 'GBP', :to => 'USD'})
    @rate_map[params[:from]][params[:to]]
  end

  
  def rate_map_exists?(params={:from => 'USD', :to => 'GBP'})
    @rate_map[params[:from]] and @rate_map[params[:from]][params[:to]]
  end

  # recursion
  def rate(params={:from => 'USD', :to => 'CAD'})
    if(rate_map_exists?(params)) # this is the base condition
      return get_known_rate(params)
    else
      get_closer(params) # this is the recursive work
      rate(params)
    end
  end

  def get_closer(params)
    new_entries = []
    @rate_map[params[:from]].each do |key, value|
      @rate_map[key].each do |child_key, child_value|
        unless rate_map_exists?({:from => params[:from], :to => child_key})
          new_rate = get_known_rate({:from => params[:from], :to => key}) * get_known_rate({:from => key, :to => child_key})
          new_entries << {:from => params[:from], :to => child_key, :conversion => new_rate}
        end
      end
    end
    new_entries.each {|new_entry| set_rate_map_for(new_entry)}
  end

end
