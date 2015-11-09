require './model/unit'

class RectangularUnit < Unit
  # @return [Float]
  attr_reader :width

  # @return [Float]
  attr_reader :height

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
  def initialize(id, mass, x, y, speed_x, speed_y, angle, angular_speed, width, height)
    super(id, mass, x, y, speed_x, speed_y, angle, angular_speed)

    @width = width
    @height = height
  end
end