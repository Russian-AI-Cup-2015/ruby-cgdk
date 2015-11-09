require './model/circular_unit'
require './model/projectile_type'

class Projectile < CircularUnit
  # @return [Integer]
  attr_reader :car_id

  # @return [Integer]
  attr_reader :player_id

  # @return [Integer, NilClass]
  attr_reader :type

  # @param [Integer] id
  # @param [Float] mass
  # @param [Float] x
  # @param [Float] y
  # @param [Float] speed_x
  # @param [Float] speed_y
  # @param [Float] angle
  # @param [Float] angular_speed
  # @param [Float] radius
  # @param [Integer] car_id
  # @param [Integer] player_id
  # @param [Integer, NilClass] type
  def initialize(id, mass, x, y, speed_x, speed_y, angle, angular_speed, radius, car_id, player_id, type)
    super(id, mass, x, y, speed_x, speed_y, angle, angular_speed, radius)

    @car_id = car_id
    @player_id = player_id
    @type = type
  end
end