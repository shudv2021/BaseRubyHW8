require_relative 'carriages.rb'
class CargoCarriage < Carriage
  attr_reader :type
  def initialize(carr_num)
    super
    @type = :cargo
    #increase_counter
  end
end