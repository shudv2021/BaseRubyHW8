require_relative 'rail_way.rb'
require_relative 'train.rb'
require_relative 'pasanger_train.rb'
require_relative 'cargo_carriage.rb'
require_relative 'passanger_carriage.rb'
require_relative 'cargo_train.rb'
require_relative 'route.rb'
require_relative 'stations.rb'
require_relative 'modules.rb'

rr = RailWay.new
rr.seed
rr.interface

