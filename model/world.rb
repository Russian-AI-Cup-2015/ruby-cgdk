require './model/bonus'
require './model/car'
require './model/direction'
require './model/oil_slick'
require './model/player'
require './model/projectile'
require './model/tile_type'

# noinspection RubyTooManyInstanceVariablesInspection
class World
  # @return [Integer]
  attr_reader :tick

  # @return [Integer]
  attr_reader :tick_count

  # @return [Integer]
  attr_reader :last_tick_index

  # @return [Integer]
  attr_reader :width

  # @return [Integer]
  attr_reader :height

  # @return [Array<Player, NilClass>, NilClass]
  attr_reader :players

  # @return [Array<Car, NilClass>, NilClass]
  attr_reader :cars

  # @return [Array<Projectile, NilClass>, NilClass]
  attr_reader :projectiles

  # @return [Array<Bonus, NilClass>, NilClass]
  attr_reader :bonuses

  # @return [Array<OilSlick, NilClass>, NilClass]
  attr_reader :oil_slicks

  # @return [String, NilClass]
  attr_reader :map_name

  # @return [Array<Array<Integer, NilClass>, NilClass>, NilClass]
  attr_reader :tiles_x_y

  # @return [Array<Array<Integer>, NilClass>, NilClass]
  attr_reader :waypoints

  # @return [Integer, NilClass]
  attr_reader :starting_direction

  # @param [Integer] tick
  # @param [Integer] tick_count
  # @param [Integer] last_tick_index
  # @param [Integer] width
  # @param [Integer] height
  # @param [Array<Player, NilClass>, NilClass] players
  # @param [Array<Car, NilClass>, NilClass] cars
  # @param [Array<Projectile, NilClass>, NilClass] projectiles
  # @param [Array<Bonus, NilClass>, NilClass] bonuses
  # @param [Array<OilSlick, NilClass>, NilClass] oil_slicks
  # @param [String, NilClass] map_name
  # @param [Array<Array<Integer, NilClass>, NilClass>, NilClass] tiles_x_y
  # @param [Array<Array<Integer>, NilClass>, NilClass] waypoints
  # @param [Integer, NilClass] starting_direction
  def initialize(tick, tick_count, last_tick_index, width, height, players, cars, projectiles, bonuses, oil_slicks,
                 map_name, tiles_x_y, waypoints, starting_direction)
    @tick = tick
    @tick_count = tick_count
    @last_tick_index = last_tick_index
    @width = width
    @height = height
    @players = players
    @cars = cars
    @projectiles = projectiles
    @bonuses = bonuses
    @oil_slicks = oil_slicks
    @map_name = map_name
    @tiles_x_y = tiles_x_y
    @waypoints = waypoints
    @starting_direction = starting_direction
  end

  # @return [Player, NilClass]
  def my_player
    @players.each do |player|
      if player.me
        return player
      end
    end

    nil
  end
end