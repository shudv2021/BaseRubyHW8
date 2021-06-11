require_relative 'carriages'
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

  def show_use
    @use_place
  end
end
