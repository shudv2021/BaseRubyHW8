require_relative 'train'
require_relative 'counter'
class CargoTrain < Train
  def initialize(train_num)
    super
    @type = :cargo
  end
end
