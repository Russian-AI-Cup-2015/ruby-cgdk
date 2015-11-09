require './model/bonus_type'
require './model/rectangular_unit'

class Bonus < RectangularUnit
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
  # @param [Float] width
  # @param [Float] height
  # @param [Integer, NilClass] type
  def initialize(id, mass, x, y, speed_x, speed_y, angle, angular_speed, width, height, type)
    super(id, mass, x, y, speed_x, speed_y, angle, angular_speed, width, height)

    @type = type
  end
end