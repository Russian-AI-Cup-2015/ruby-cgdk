require './model/unit'

class CircularUnit < Unit
  # @return [Float]
  attr_reader :radius

  # @param [Integer] id
  # @param [Float] mass
  # @param [Float] x
  # @param [Float] y
  # @param [Float] speed_x
  # @param [Float] speed_y
  # @param [Float] angle
  # @param [Float] angular_speed
  # @param [Float] radius
  def initialize(id, mass, x, y, speed_x, speed_y, angle, angular_speed, radius)
    super(id, mass, x, y, speed_x, speed_y, angle, angular_speed)

    @radius = radius
  end
end