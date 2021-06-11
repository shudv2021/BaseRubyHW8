require_relative 'carriages'
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

  def show_use
    @use_place
  end
end
