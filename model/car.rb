require './model/car_type'
require './model/rectangular_unit'

# noinspection RubyInstanceVariableNamingConvention,RubyParameterNamingConvention,RubyTooManyInstanceVariablesInspection
class Car < RectangularUnit
  # @return [Integer]
  attr_reader :player_id

  # @return [Integer]
  attr_reader :teammate_index

  # @return [TrueClass, FalseClass]
  attr_reader :teammate

  # @return [Integer, NilClass]
  attr_reader :type

  # @return [Integer]
  attr_reader :projectile_count

  # @return [Integer]
  attr_reader :nitro_charge_count

  # @return [Integer]
  attr_reader :oil_canister_count

  # @return [Integer]
  attr_reader :remaining_projectile_cooldown_ticks

  # @return [Integer]
  attr_reader :remaining_nitro_cooldown_ticks

  # @return [Integer]
  attr_reader :remaining_oil_cooldown_ticks

  # @return [Integer]
  attr_reader :remaining_nitro_ticks

  # @return [Integer]
  attr_reader :remaining_oiled_ticks

  # @return [Float]
  attr_reader :durability

  # @return [Float]
  attr_reader :engine_power

  # @return [Float]
  attr_reader :wheel_turn

  # @return [Integer]
  attr_reader :next_waypoint_x

  # @return [Integer]
  attr_reader :next_waypoint_y

  # @return [TrueClass, FalseClass]
  attr_reader :finished_track

  # @param [Integer] id
  # @param [Float] mass
  # @param [Float] x
  # @param [Float] y
  # @param [Float] speed_x
  # @param [Float] speed_y
  # @param [Float] angle
  # @param [Float] angular_speed
  # @param [Float] width
  # @param [Float] height
  # @param [Integer] player_id
  # @param [Integer] teammate_index
  # @param [TrueClass, FalseClass] teammate
  # @param [Integer, NilClass] type
  # @param [Integer] projectile_count
  # @param [Integer] nitro_charge_count
  # @param [Integer] oil_canister_count
  # @param [Integer] remaining_projectile_cooldown_ticks
  # @param [Integer] remaining_nitro_cooldown_ticks
  # @param [Integer] remaining_oil_cooldown_ticks
  # @param [Integer] remaining_nitro_ticks
  # @param [Integer] remaining_oiled_ticks
  # @param [Float] durability
  # @param [Float] engine_power
  # @param [Float] wheel_turn
  # @param [Integer] next_waypoint_x
  # @param [Integer] next_waypoint_y
  # @param [TrueClass, FalseClass] finished_track
  def initialize(id, mass, x, y, speed_x, speed_y, angle, angular_speed, width, height, player_id, teammate_index,
                 teammate, type, projectile_count, nitro_charge_count, oil_canister_count,
                 remaining_projectile_cooldown_ticks, remaining_nitro_cooldown_ticks, remaining_oil_cooldown_ticks,
                 remaining_nitro_ticks, remaining_oiled_ticks, durability, engine_power, wheel_turn, next_waypoint_x,
                 next_waypoint_y, finished_track)
    super(id, mass, x, y, speed_x, speed_y, angle, angular_speed, width, height)

    @player_id = player_id
    @teammate_index = teammate_index
    @teammate = teammate
    @type = type
    @projectile_count = projectile_count
    @nitro_charge_count = nitro_charge_count
    @oil_canister_count = oil_canister_count
    @remaining_projectile_cooldown_ticks = remaining_projectile_cooldown_ticks
    @remaining_nitro_cooldown_ticks = remaining_nitro_cooldown_ticks
    @remaining_oil_cooldown_ticks = remaining_oil_cooldown_ticks
    @remaining_nitro_ticks = remaining_nitro_ticks
    @remaining_oiled_ticks = remaining_oiled_ticks
    @durability = durability
    @engine_power = engine_power
    @wheel_turn = wheel_turn
    @next_waypoint_x = next_waypoint_x
    @next_waypoint_y = next_waypoint_y
    @finished_track = finished_track
  end
end