class Move
  # @return [Float]
  attr_accessor :engine_power

  # @return [TrueClass, FalseClass]
  attr_accessor :brake

  # @return [Float]
  attr_accessor :wheel_turn

  # @return [TrueClass, FalseClass]
  attr_accessor :throw_projectile

  # @return [TrueClass, FalseClass]
  attr_accessor :use_nitro

  # @return [TrueClass, FalseClass]
  attr_accessor :spill_oil

  def initialize
    @engine_power = 0.0
    @brake = false
    @wheel_turn = 0.0
    @throw_projectile = false
    @use_nitro = false
    @spill_oil = false
  end
end