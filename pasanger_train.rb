require_relative 'train'
class PasangerTrain < Train
  def initialize(train_num)
    super
    @type = :passanger
  end
end
