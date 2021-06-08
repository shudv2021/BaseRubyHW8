require_relative 'train.rb'
class PasangerTrain < Train
  def initialize(train_num)
    super
    @type = :passanger
  end
end