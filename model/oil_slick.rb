require './model/circular_unit'

class OilSlick < CircularUnit
  # @return [Integer]
  attr_reader :remaining_lifetime

  # @param [Integer] id
  # @param [Float] mass
  # @param [Float] x
  # @param [Float] y
  # @param [Float] speed_x
  # @param [Float] speed_y
  # @param [Float] angle
  # @param [Float] angular_speed
  # @param [Float] radius
  # @param [Integer] remaining_lifetime
  def initialize(id, mass, x, y, speed_x, speed_y, angle, angular_speed, radius, remaining_lifetime)
    super(id, mass, x, y, speed_x, speed_y, angle, angular_speed, radius)

    @remaining_lifetime = remaining_lifetime
  end
end