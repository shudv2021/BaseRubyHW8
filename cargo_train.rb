require_relative 'train.rb'
require_relative 'counter.rb'
class CargoTrain < Train
  def initialize(train_num)
    super
    @type = :cargo
  end
end
