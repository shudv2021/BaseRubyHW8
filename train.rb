require_relative 'modules.rb'
require_relative 'counter.rb'
require_relative 'rail_way.rb'

class Train
  include Producer
  include Counter
  @@train_all = []
  @@instances = 0
  def self.find(train_num, cagro = 10)
    @@train_all.each do |train|
      return train if train.train_num == train_num
    end
    return nil
  end

  TRAIN_NUMBER_FORMAT =/[0-9]{3}-[а-я]{2}$/i

  attr_reader :train_num, :route, :current_station, :speed, :type, :total_carriages

  def initialize(train_num)
    @train_num = train_num
    validate!
    @total_carriages = []
    @route
    @speed = 0
    @@train_all<<self
    increase_counter
  end

  def add_speed(add_sp)
    @speed += add_sp
  end

  def stop
    @speed = 0
  end

  def add_carriage(carriage)

    if @speed != 0
      puts 'Невозможно добавить вагон в движущийся состав.'
    return nil
    elsif carriage.type != self.type
      puts 'Невозможно добавить вагон в состав другого типа.'
    return nil
    else @total_carriages.push(carriage)
    end
  end

  def unhook
    @total_carriages.pop if @speed == 0
  end

  def sent_train(route)
    @current_station.delete_train(self) if @current_station != nil
    @route = route
    @current_station = route.all_stations[0]
    @current_station.all_trains.push(self)
  end

  def move_back
    move(prev_station)
  end

  def move_forvard
    move(next_station)
  end

  def list_carriages(&block)
    @total_carriages.each do |carriage|
    if block_given?
      yield(carriage)
    else ' Не передан шаблон для обработки '
    end
    end
  end

  private
  def prev_station
    if @route.all_stations.index(@current_station) == 0
      return nil
    else
      @route.all_stations[@route.all_stations.index(@current_station) - 1]
    end
  end

  def next_station
    if @route.all_stations.index(@current_station)  == @route.all_stations.size
      return nil
    else
      return @route.all_stations[@route.all_stations.index(@current_station) + 1]
    end
  end

  def move(station)
    if station.nil?
      puts ' Движение на заданную станцию невозможно '
      return nil
    end
    @current_station.all_trains.delete(self)
    @current_station = station
    @current_station.all_trains.push(self)
  end


  def valide_format!
    (@train_num =~ TRAIN_NUMBER_FORMAT) == 0
  end

  def validate!
    raise ' Неверный формат имение поезда. ' unless valide_format!
  end

end