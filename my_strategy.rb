require './model/car'
require './model/game'
require './model/move'
require './model/world'

class MyStrategy
  # @param [Car] me
  # @param [World] world
  # @param [Game] game
  # @param [Move] move
  def move(me, world, game, move)
    move.engine_power = 1.0
    move.throw_projectile = true
    move.spill_oil = true

    if world.tick > game.initial_freeze_duration_ticks
        move.use_nitro = true
    end
  end
end