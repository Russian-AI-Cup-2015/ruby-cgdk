class Player
  # @return [Integer]
  attr_reader :id

  # @return [TrueClass, FalseClass]
  attr_reader :me

  # @return [String, NilClass]
  attr_reader :name

  # @return [TrueClass, FalseClass]
  attr_reader :strategy_crashed

  # @return [Integer]
  attr_reader :score

  # @param [Integer] id
  # @param [TrueClass, FalseClass] me
  # @param [String, NilClass] name
  # @param [TrueClass, FalseClass] strategy_crashed
  # @param [Integer] score
  def initialize(id, me, name, strategy_crashed, score)
    @id = id
    @me = me
    @name = name
    @strategy_crashed = strategy_crashed
    @score = score
  end
end