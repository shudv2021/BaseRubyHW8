require_relative 'carriages.rb'
class PassangerCarriage < Carriage
  attr_reader :type, :seats_available, :use_place
  def initialize(carr_num, cargo = 40)
    super
    @type = :passanger
    @seats_available = cargo
    @use_place = 0
  end

  def add_passanger
    @use_place += 1 if @use_place < @seats_available
    nil if @use_place >= @seats_available
  end

  def show_avaliable
    @seats_available - @use_place
  end

  #Метод можно убрать и использовать attr_reader для use_place, но делаю как сформулировано дз
  def show_use
    @use_place
  end
  #методы добавления груза не сделаны в родительском классе потому что использованны разные типы чисел здесь
  # Integer  а в грузовом вагоне Float
end