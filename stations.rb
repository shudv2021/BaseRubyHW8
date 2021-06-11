require_relative 'counter'

class Station
  include Counter
  attr_reader :station_name, :all_trains

  @@station_all = []

  STATION_FORMAT = /[а-я]*$/i.freeze

  def self.gett_all
    @@station_all
  end

  def initialize(station_name)
    @station_name = station_name
    validate!
    @all_trains = []
    @@station_all << self
    increase_counter
  end

  def add_train(train)
    @all_trains << train
  end

  def delete_train(train)
    @all_trains.delete(train)
  end

  def return_all_trains
    @all_trains
  end

  def list_trains_on_stations
    @all_trains.each do |train|
      yield(train) if block_given?
    end
  end

  private

  def valide_format!
    (@station_name =~ STATION_FORMAT).zero?
  end

  def validate!
    raise ' Неверный формат имени станции. ' unless valide_format!
  end
end
