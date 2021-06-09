require_relative 'route.rb'
require_relative 'stations.rb'
require_relative 'train.rb'
require_relative 'pasanger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'cargo_carriage.rb'
require_relative 'passanger_carriage.rb'
require_relative 'modules.rb'

class RailWay


  def initialize
    @total_stations = []
    @total_routs = []
    @total_trains = []
    @total_carriages = []
  end

  def seed
    start_stations = %w[Краснодар Ростов Воронеж Москва Владимир]
    start_stations.each { |station| @total_stations<<Station.new(station) }
    total_trains.push(CargoTrain.new('111-гп'))
    train_by_num('111-гп').producer= ('BMW')
    total_trains.push(CargoTrain.new('222-гп'))
    total_trains.push(PasangerTrain.new('333-пп'))
    total_trains.push(PasangerTrain.new('444-пп'))
    #Создаем вагоны
    total_carriages.push(CargoCarriage.new('111-гв'))
    carriage_by_num('111-гв').producer= ('BMW')
    total_carriages.push(CargoCarriage.new('222-гв'))
    total_carriages.push(PassangerCarriage.new('333-пв'))
    carriage_by_num('333-пв').producer= ('ReinMetall')
    total_carriages.push(PassangerCarriage.new('444-пв'))
    #Создаем пробный маршрут
    total_routs << Route.new(total_stations[0], total_stations[4])
    total_routs[0].add_station(1, total_stations[1])
    total_routs[0].add_station(2, total_stations[2])
    total_routs[0].add_station(3, total_stations[3])
    #отправляем поезда по маршруту
    train_by_num('111-гп').sent_train(total_routs[0])
    train_by_num('222-гп').sent_train(total_routs[0])
    train_by_num('333-пп').sent_train(total_routs[0])
    train_by_num('444-пп').sent_train(total_routs[0])
    #Добавляем вагоны поезду 111-гп
    train_by_num('111-гп').add_carriage(carriage_by_num('111-гв'))
    train_by_num('111-гп').add_carriage(carriage_by_num('222-гв'))
    train_by_num('333-пп').add_carriage(carriage_by_num('333-пв'))
    train_by_num('333-пп').add_carriage(carriage_by_num('444-пв'))

  end

  def interface
    loop do
    system 'clear'
    # По идеее  строка должна очищать поле вывода, но я вижу всю простыню сообщений
    # после каждой операции
    puts ' Запущена программа железная дорога '
    puts ' 1.Создать станцию '
    puts ' 2.Показать все станции '
    puts ' 21 показать все станции через переменную класса станции '
    puts ' 3.Показать все поезда на станции '
    puts ' 31.Показать все поеда на станции используя блок. '
    puts ' 4.Создать поезд '
    puts ' 41 Показать поез под номером'
    puts ' 5.Создать маршрут '
    puts ' 6.Добавить станцию на маршрут '
    puts ' 7.Удалить станцию с маршрута '
    puts ' 8.Показать все маршруты'
    puts ' 9.Назначить поезду маршрут '
    puts ' 91. Создать новый вагон '
    puts ' 92. Заполнить вагон '
    puts ' 10.Добавить вагон к поезду '
    puts ' 11.Отцепить вагон от поезда '
    puts ' 12.Отправить поезд вперед '
    puts ' 13.Отправить поезд назад '
    puts ' 14.Выйти из программы'
    print ' Выберете действие: '
    action = gets.chomp

    case action
    when '1'
      create_station
    when '2'
      show_all_stations
    when '3'
      show_trains_on_starions
    when '4'
      create_train
    when '5'
      create_route
    when '6'
      add_station_on_route
    when '7'
      del_station_from_route
    when '8'
      self.show_all_rotes
    when '9'
      sent_train_by_route
    when '10'
      add_carriage_to_train
    when '11'
      del_carriage_from_train
    when '12'
      sent_train_forvard
    when '13'
      sent_train_back
    when '14'
      #проверка идет ли подсчет элементов на жд
      puts '************************************************************'
      puts ' В процессе работы программы было создано: '
      puts "поездов без типа- #{Train.counter}"
      puts "грузовых поездов - #{CargoTrain.counter}"
      puts "пассажирсикх поездов - #{PasangerTrain.counter}"
      puts "станций - #{Station.counter}"
      puts "грузовых вагонов - #{CargoCarriage.counter}"
      puts "пассажирских вагонов - #{PassangerCarriage.counter}"
      puts '*************************************************************'
      finished_all
    when '21'
      show_all_stations_by_all
    when '31'
      list_trains_on_station
    when '41'
      show_train_by_num
    when '91'
      create_carriage
    when '92'
    add_in_carriage
    end
    end
  end

  private
  attr_accessor :total_stations, :total_routs, :total_trains, :total_carriages

  def create_station
    puts 'Введите название станции:'
    station_name = gets.chomp
    self.total_stations.push(Station.new(station_name))
    puts " Станция #{station_name} добавлена. "
  rescue
    puts ' Неверный формат имени станции. Наберите название станции по русски. '
  end

  def show_all_stations
    total_stations.each { |station| puts station.station_name}
  end

  def show_trains_on_starions
    print 'Введите название станции: '
    station = gets.chomp
    puts all_trains = station_by_name(station).return_all_trains
    puts "На станции #{station} находятся:"
    all_trains.each { |train| puts "*#{train.type}  Поезд №  #{train.train_num}* производитель #{train.producer}"}
  end

  def list_trains_on_station
    print 'Введите название станции: '
    station = gets.chomp
    station_by_name(station).list_trains_on_stations{ |train| puts "--#{train.train_num} ** #{train.type} ** #{train.total_carriages.size}--"}
  end


  def create_train
    print ' Выберите тип новго поезда 1.Пассажирски/2.Грузовой: '
    type = gets.chomp
    print 'Введите номер поезда:'
    train_num = gets.chomp
    add_train(type, train_num)
  end

  def create_carriage
    print ' Выберите тип новго вагона 1.Пассажирски/2.Грузовой: '
    type = gets.chomp
    print 'Введите номер вагона:'
    carriage_num = gets.chomp
    print ' Введите количество мест/максимальную загрузку:'
    cargo = gets.chomp
    create_new_carriage(type, carriage_num, cargo)
  end

  def add_in_carriage
    print ' Введите номер вагона '
    carr_num = gets.chomp
    if carriage_by_num(carr_num).type == :cargo
      print "Введите обьем погрузки не (не больше #{carriage_by_num(carr_num).show_avaliable}):"
      carriage_by_num(carr_num).add_good(gets.chomp.to_f)
    else
      carriage_by_num(carr_num).add_passanger
    end
  end

  def create_route
    print 'Введите первую станцию маршрута:'
    start_station = gets.chomp
    print ' Введите конечную станцию маршрута:'
    finish_station = gets.chomp
    total_routs.push(Route.new(station_by_name(start_station), station_by_name(finish_station)))
  end

  def add_station_on_route
    print ' Выберите номер изменяемого маршрута: '
    route_index = gets.chomp.to_i
    print ' Выберите положение станции (номер стенции на маршруте): '
    station_locat = gets.chomp.to_i
    print ' Введите станцию которую хотите добавить: '
    station_name = gets.chomp
    total_routs[route_index - 1].add_station(station_locat, station_by_name(station_name)).delete(nil )
  end

  def del_station_from_route
    print ' Выберите номер изменяемого маршрута: '
    route_index = gets.chomp.to_i
    print ' Введите название удаляемой станции :'
    station_name = gets.chomp
    total_routs[route_index - 1].delete_station(station_by_name(station_name))
  end

  def sent_train_by_route
    print 'Введите номер поезда: '
    train_num = gets.chomp.to_i
    print ' Введите номер маршрута: '
    route_index = gets.chomp.to_i
    train_by_num(train_num).sent_train(total_routs[route_index - 1])
  end

  def add_carriage_to_train
    print 'Выберите поезд:'
    train_num = gets.chomp
    print 'Выберите вагон для довбавления:'
    carriage_num = gets.chomp
    train_by_num(train_num).add_carriage(carriage_by_num(carriage_num))
    puts " Вагон #{carriage_num} добавлен к поезду #{train_num} "
  rescue
    puts 'Операция по добавлению вагона провалена. '
  end

  def del_carriage_from_train
    print 'Выберите поезд:'
    train_num = gets.chomp.to_i
    train_by_num(train_num).unhook
  end

  def sent_train_forvard
    print 'Выберите поезд:'
    train_num = gets.chomp.to_i
    train_by_num(train_num).move_forvard
  end

  def sent_train_back
    print 'Выберите поезд:'
    train_num = gets.chomp.to_i
    train_by_num(train_num).move_back
  end

  def finished_all
    puts ' Программа железная дорога завершена.'
    exit
  end

  def show_all_stations_by_all
    Station.get_all.each { |station| puts station.station_name}
  end

  def station_by_name(station_name)
    @total_stations.each do |station|
      return station if station.station_name == station_name
    end
  end

  def train_by_num(train_num)
    @total_trains.each do |train|
      return train if train.train_num == train_num
    end
    raise "Операция невозможна, нет поезда #{train_num}"
  end

  def show_train_by_num
    #Показывает обьект поезд по выбранному номеру используя метод класс
    print ' Введите номер поезда:'
    train_num = gets.chomp
    #Метод дополнен блоком согласно заданию урока 8
    #puts Train.find(train_num).inspect
    Train.find(train_num).list_carriages do |carr|
      if carr.type == :cargo
      puts "вагон номер #{carr.carr_num} загружено #{carr.show_use}тн. /свободно #{carr.show_avaliable}тн."
      else puts "вагон номер #{carr.carr_num} занято #{carr.show_use} мест /свободно #{carr.show_avaliable} мест."
      end
      end
  end

  def carriage_by_num(carriage_num)
    @total_carriages.each do |carriage|
      return carriage if carriage.carr_num == carriage_num
    end
    raise "Операция невозможна, такго вагона #{carriage_num} нет "
  end

  def add_train(type, train_num)
    if type == '2'
      total_trains.push(CargoTrain.new(train_num))
      puts "Создан грузовой поезд#{train_num}"
    elsif type == '1'
      total_trains.push(PasangerTrain.new(train_num))
      puts "Создан пассажирский поезд #{train_num}"
    else puts ' Введен недопустимй тип вагона'
    end
  rescue
    puts ' Введеннй формат поезда неверен. Допустимый формат №№№-АА. '
  end

  def create_new_carriage(type, carriage_num, cargo)
    if type == '1'
      total_carriages.push(PassangerCarriage.new(carriage_num, cargo.to_i))
      puts "Создан пассажирский вагон #{carriage_num}"
    elsif type  == '2'
      total_carriages.push(CargoCarriage.new(carriage_num, cargo.to_f))
      puts "Создан грузовой вагон #{carriage_num}"
    else puts ' Введен недопустимый тип вагона'
    #rescue puts ' Введеннй формат вагона неверен. Допустимый формат №№№-АА. '
    end

  end

  def show_all_rotes
    self.total_routs.each_with_index do |route, index|
      print " Маршрут #{index + 1}: "
      route.all_stations.each do |station|
        print " *#{station.station_name}* "
      end
      puts " \n_____________________________________ "
    end
  end

end


