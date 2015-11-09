require './model/car'
require './model/world'

class PlayerContext
  # @return [Array<Car, NilClass>, NilClass]
  attr_reader :cars

  # @return [World, NilClass]
  attr_reader :world

  # @param [Array<Car, NilClass>, NilClass] cars
  # @param [World, NilClass] world
  def initialize(cars, world)
    @cars = cars
    @world = world
  end
end