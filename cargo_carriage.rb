require_relative 'carriages.rb'
class CargoCarriage < Carriage
  attr_reader :type, :availiable_place, :use_place
  def initialize(carr_num, cargo = 10)
    super
    @type = :cargo
    @availiable_goods = cargo
    @use_place = 0.0
  end

  def add_good(goods)
    @use_place += goods if @use_place < @availiable_goods
    nil if @use_place >= @availiable_goods
  end

  def show_avaliable
    @availiable_goods - @use_place
  end

  #Метод можно убрать и использовать attr_reader для use_place, но делаю как сформулировано дз
  def show_use
    @use_place
  end
  #методы добавления груза не сделаны в родительском классе потому что использованны разные типы чисел здесь
  # Integer  а в грузовом вагоне Float


end