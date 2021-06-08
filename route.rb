class Route
  attr_reader :all_stations
  #Все методы используются другими классами
  def initialize(start_staition, finish_station)
    @all_stations =[start_staition, finish_station]
  end

  def add_station (location, new_station)
    if @all_stations.include?(new_station)
      return nil
    else @all_stations.insert(location, new_station)
    end
  end

  def delete_station(station_del)
    @all_stations.delete(station_del)
  end

end
