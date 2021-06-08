require_relative 'carriages.rb'
class PassangerCarriage < Carriage
  attr_reader :type
  def initialize(carr_num)
    super
    @type = :passanger
    #increase_counter
  end
end