require_relative 'modules'
require_relative 'counter'

class Carriage
  include Producer
  include Counter
  attr_reader :carr_num

  CARRIAGE_NAMBER_FORMAT = /[0-9]{3}-[а-я]{2}$/i.freeze

  def initialize(carr_num, _cargo = 10)
    @carr_num = carr_num
    validate!
    increase_counter
  end

  private

  def valide_format!
    (@carr_num =~ CARRIAGE_NAMBER_FORMAT).zero?
  end

  def validate!
    raise ' Неверный формат имение вагона. ' unless valide_format!
  end
end
