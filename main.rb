require_relative 'rail_way'
require_relative 'train'
require_relative 'pasanger_train'
require_relative 'cargo_carriage'
require_relative 'passanger_carriage'
require_relative 'cargo_train'
require_relative 'route'
require_relative 'stations'
require_relative 'modules'

rr = RailWay.new
rr.seed
rr.interface
