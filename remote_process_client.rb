require 'socket'
require './model/bonus'
require './model/bonus_type'
require './model/car'
require './model/car_type'
require './model/circular_unit'
require './model/direction'
require './model/game'
require './model/move'
require './model/oil_slick'
require './model/player'
require './model/player_context'
require './model/projectile'
require './model/projectile_type'
require './model/rectangular_unit'
require './model/tile_type'
require './model/unit'
require './model/world'

# noinspection RubyTooManyMethodsInspection
class RemoteProcessClient
  LITTLE_ENDIAN_BYTE_ORDER = true

  BYTE_ORDER_FORMAT_STRING = LITTLE_ENDIAN_BYTE_ORDER ? '<' : '>'

  SIGNED_BYTE_SIZE_BYTES = 1
  INTEGER_SIZE_BYTES = 4
  LONG_SIZE_BYTES = 8
  DOUBLE_SIZE_BYTES = 8

  @map_name = nil
  @tiles_x_y = nil
  @waypoints = nil
  @starting_direction = nil

  def initialize(host, port)
    @socket = TCPSocket::new(host, port)
  end

  def write_token_message(token)
    write_enum(MessageType::AUTHENTICATION_TOKEN)
    write_string(token)
  end

  def read_team_size_message
    ensure_message_type(read_enum(MessageType), MessageType::TEAM_SIZE)
    read_int
  end

  def write_protocol_version_message
    write_enum(MessageType::PROTOCOL_VERSION)
    write_int(1)
  end

  def read_game_context_message
    ensure_message_type(read_enum(MessageType), MessageType::GAME_CONTEXT)
    read_game
  end

  def read_player_context_message
    message_type = read_enum(MessageType)
    if message_type == MessageType::GAME_OVER
      return nil
    end

    ensure_message_type(message_type, MessageType::PLAYER_CONTEXT)
    read_player_context
  end

  def write_moves_message(moves)
    write_enum(MessageType::MOVES)
    write_moves(moves)
  end

  def read_bonus
    unless read_boolean
      return nil
    end

    Bonus::new(read_long, read_double, read_double, read_double, read_double, read_double, read_double, read_double,
               read_double, read_double, read_enum(BonusType))
  end

  def write_bonus(bonus)
    if bonus.nil?
      write_boolean(false)
    else
      write_boolean(true)

      write_long(bonus.id)
      write_double(bonus.mass)
      write_double(bonus.x)
      write_double(bonus.y)
      write_double(bonus.speed_x)
      write_double(bonus.speed_y)
      write_double(bonus.angle)
      write_double(bonus.angular_speed)
      write_double(bonus.width)
      write_double(bonus.height)
      write_enum(bonus.type)
    end
  end

  def read_bonuses
    bonus_count = read_int
    if bonus_count < 0
      return nil
    end

    bonuses = []

    bonus_count.times do |_|
      bonuses.push(read_bonus)
    end

    bonuses
  end

  def write_bonuses(bonuses)
    if bonuses.nil?
      write_int(-1)
    else
      write_int(bonuses.length)

      bonuses.each do |bonus|
        write_bonus(bonus)
      end
    end
  end

  def read_car
    unless read_boolean
      return nil
    end

    Car::new(read_long, read_double, read_double, read_double, read_double, read_double, read_double, read_double,
             read_double, read_double, read_long, read_int, read_boolean, read_enum(CarType), read_int, read_int,
             read_int, read_int, read_int, read_int, read_int, read_int, read_double, read_double, read_double,
             read_int, read_int, read_boolean)
  end

  def write_car(car)
    if car.nil?
      write_boolean(false)
    else
      write_boolean(true)

      write_long(car.id)
      write_double(car.mass)
      write_double(car.x)
      write_double(car.y)
      write_double(car.speed_x)
      write_double(car.speed_y)
      write_double(car.angle)
      write_double(car.angular_speed)
      write_double(car.width)
      write_double(car.height)
      write_long(car.player_id)
      write_int(car.teammate_index)
      write_boolean(car.teammate)
      write_enum(car.type)
      write_int(car.projectile_count)
      write_int(car.nitro_charge_count)
      write_int(car.oil_canister_count)
      write_int(car.remaining_projectile_cooldown_ticks)
      write_int(car.remaining_nitro_cooldown_ticks)
      write_int(car.remaining_oil_cooldown_ticks)
      write_int(car.remaining_nitro_ticks)
      write_int(car.remaining_oiled_ticks)
      write_double(car.durability)
      write_double(car.engine_power)
      write_double(car.wheel_turn)
      write_int(car.next_waypoint_x)
      write_int(car.next_waypoint_y)
      write_boolean(car.finished_track)
    end
  end

  def read_cars
    car_count = read_int
    if car_count < 0
      return nil
    end

    cars = []

    car_count.times do |_|
      cars.push(read_car)
    end

    cars
  end

  def write_cars(cars)
    if cars.nil?
      write_int(-1)
    else
      write_int(cars.length)

      cars.each do |car|
        write_car(car)
      end
    end
  end

  def read_game
    unless read_boolean
      return nil
    end

    Game::new(read_long, read_int, read_int, read_int, read_double, read_double, read_int, read_int, read_int,
              read_double, read_ints, read_int, read_double, read_double, read_int, read_double, read_double,
              read_double, read_double, read_double, read_double, read_double, read_double, read_double, read_double,
              read_int, read_int, read_int, read_double, read_int, read_int, read_double, read_double, read_double,
              read_double, read_double, read_double, read_double, read_double, read_int, read_double, read_double,
              read_double, read_double, read_double, read_double, read_double, read_double, read_double, read_double,
              read_double, read_double, read_int, read_int)
  end

  def write_game(game)
    if game.nil?
      write_boolean(false)
    else
      write_boolean(true)

      write_long(game.random_seed)
      write_int(game.tick_count)
      write_int(game.world_width)
      write_int(game.world_height)
      write_double(game.track_tile_size)
      write_double(game.track_tile_margin)
      write_int(game.lap_count)
      write_int(game.lap_tick_count)
      write_int(game.initial_freeze_duration_ticks)
      write_double(game.burning_time_duration_factor)
      write_ints(game.finish_track_scores)
      write_int(game.finish_lap_score)
      write_double(game.lap_waypoints_summary_score_factor)
      write_double(game.car_damage_score_factor)
      write_int(game.car_elimination_score)
      write_double(game.car_width)
      write_double(game.car_height)
      write_double(game.car_engine_power_change_per_tick)
      write_double(game.car_wheel_turn_change_per_tick)
      write_double(game.car_angular_speed_factor)
      write_double(game.car_movement_air_friction_factor)
      write_double(game.car_rotation_air_friction_factor)
      write_double(game.car_lengthwise_movement_friction_factor)
      write_double(game.car_crosswise_movement_friction_factor)
      write_double(game.car_rotation_friction_factor)
      write_int(game.throw_projectile_cooldown_ticks)
      write_int(game.use_nitro_cooldown_ticks)
      write_int(game.spill_oil_cooldown_ticks)
      write_double(game.nitro_engine_power_factor)
      write_int(game.nitro_duration_ticks)
      write_int(game.car_reactivation_time_ticks)
      write_double(game.buggy_mass)
      write_double(game.buggy_engine_forward_power)
      write_double(game.buggy_engine_rear_power)
      write_double(game.jeep_mass)
      write_double(game.jeep_engine_forward_power)
      write_double(game.jeep_engine_rear_power)
      write_double(game.bonus_size)
      write_double(game.bonus_mass)
      write_int(game.pure_score_amount)
      write_double(game.washer_radius)
      write_double(game.washer_mass)
      write_double(game.washer_initial_speed)
      write_double(game.washer_damage)
      write_double(game.side_washer_angle)
      write_double(game.tire_radius)
      write_double(game.tire_mass)
      write_double(game.tire_initial_speed)
      write_double(game.tire_damage_factor)
      write_double(game.tire_disappear_speed_factor)
      write_double(game.oil_slick_initial_range)
      write_double(game.oil_slick_radius)
      write_int(game.oil_slick_lifetime)
      write_int(game.max_oiled_state_duration_ticks)
    end
  end

  def read_games
    game_count = read_int
    if game_count < 0
      return nil
    end

    games = []

    game_count.times do |_|
      games.push(read_game)
    end

    games
  end

  def write_games(games)
    if games.nil?
      write_int(-1)
    else
      write_int(games.length)

      games.each do |game|
        write_game(game)
      end
    end
  end

  def read_move
    unless read_boolean
      return nil
    end

    move = Move::new

    move.engine_power = read_double
    move.brake = read_boolean
    move.wheel_turn = read_double
    move.throw_projectile = read_boolean
    move.use_nitro = read_boolean
    move.spill_oil = read_boolean

    move
  end

  def write_move(move)
    if move.nil?
      write_boolean(false)
    else
      write_boolean(true)

      write_double(move.engine_power)
      write_boolean(move.brake)
      write_double(move.wheel_turn)
      write_boolean(move.throw_projectile)
      write_boolean(move.use_nitro)
      write_boolean(move.spill_oil)
    end
  end

  def read_moves
    move_count = read_int
    if move_count < 0
      return nil
    end

    moves = []

    move_count.times do |_|
      moves.push(read_move)
    end

    moves
  end

  def write_moves(moves)
    if moves.nil?
      write_int(-1)
    else
      write_int(moves.length)

      moves.each do |move|
        write_move(move)
      end
    end
  end

  def read_oil_slick
    unless read_boolean
      return nil
    end

    OilSlick::new(read_long, read_double, read_double, read_double, read_double, read_double, read_double, read_double,
                  read_double, read_int)
  end

  def write_oil_slick(oil_slick)
    if oil_slick.nil?
      write_boolean(false)
    else
      write_boolean(true)

      write_long(oil_slick.id)
      write_double(oil_slick.mass)
      write_double(oil_slick.x)
      write_double(oil_slick.y)
      write_double(oil_slick.speed_x)
      write_double(oil_slick.speed_y)
      write_double(oil_slick.angle)
      write_double(oil_slick.angular_speed)
      write_double(oil_slick.radius)
      write_int(oil_slick.remaining_lifetime)
    end
  end

  def read_oil_slicks
    oil_slick_count = read_int
    if oil_slick_count < 0
      return nil
    end

    oil_slicks = []

    oil_slick_count.times do |_|
      oil_slicks.push(read_oil_slick)
    end

    oil_slicks
  end

  def write_oil_slicks(oil_slicks)
    if oil_slicks.nil?
      write_int(-1)
    else
      write_int(oil_slicks.length)

      oil_slicks.each do |oil_slick|
        write_oil_slick(oil_slick)
      end
    end
  end

  def read_player
    unless read_boolean
      return nil
    end

    Player::new(read_long, read_boolean, read_string, read_boolean, read_int)
  end

  def write_player(player)
    if player.nil?
      write_boolean(false)
    else
      write_boolean(true)

      write_long(player.id)
      write_boolean(player.me)
      write_string(player.name)
      write_boolean(player.strategy_crashed)
      write_int(player.score)
    end
  end

  def read_players
    player_count = read_int
    if player_count < 0
      return nil
    end

    players = []

    player_count.times do |_|
      players.push(read_player)
    end

    players
  end

  def write_players(players)
    if players.nil?
      write_int(-1)
    else
      write_int(players.length)

      players.each do |player|
        write_player(player)
      end
    end
  end

  def read_player_context
    unless read_boolean
      return nil
    end

    PlayerContext::new(read_cars, read_world)
  end

  def write_player_context(player_context)
    if player_context.nil?
      write_boolean(false)
    else
      write_boolean(true)

      write_cars(player_context.cars)
      write_world(player_context.world)
    end
  end

  def read_player_contexts
    player_context_count = read_int
    if player_context_count < 0
      return nil
    end

    player_contexts = []

    player_context_count.times do |_|
      player_contexts.push(read_player_context)
    end

    player_contexts
  end

  def write_player_contexts(player_contexts)
    if player_contexts.nil?
      write_int(-1)
    else
      write_int(player_contexts.length)

      player_contexts.each do |player_context|
        write_player_context(player_context)
      end
    end
  end

  def read_projectile
    unless read_boolean
      return nil
    end

    Projectile::new(read_long, read_double, read_double, read_double, read_double, read_double, read_double,
                    read_double, read_double, read_long, read_long, read_enum(ProjectileType))
  end

  def write_projectile(projectile)
    if projectile.nil?
      write_boolean(false)
    else
      write_boolean(true)

      write_long(projectile.id)
      write_double(projectile.mass)
      write_double(projectile.x)
      write_double(projectile.y)
      write_double(projectile.speed_x)
      write_double(projectile.speed_y)
      write_double(projectile.angle)
      write_double(projectile.angular_speed)
      write_double(projectile.radius)
      write_long(projectile.car_id)
      write_long(projectile.player_id)
      write_enum(projectile.type)
    end
  end

  def read_projectiles
    projectile_count = read_int
    if projectile_count < 0
      return nil
    end

    projectiles = []

    projectile_count.times do |_|
      projectiles.push(read_projectile)
    end

    projectiles
  end

  def write_projectiles(projectiles)
    if projectiles.nil?
      write_int(-1)
    else
      write_int(projectiles.length)

      projectiles.each do |projectile|
        write_projectile(projectile)
      end
    end
  end

  def read_world
    unless read_boolean
      return nil
    end

    World::new(read_int, read_int, read_int, read_int, read_int, read_players, read_cars, read_projectiles,
               read_bonuses, read_oil_slicks, @map_name.nil? ? @map_name = read_string : @map_name,
               @tiles_x_y.nil? ? @tiles_x_y = read_enums_2d(TileType) : @tiles_x_y,
               @waypoints.nil? ? @waypoints = read_ints_2d : @waypoints,
               @starting_direction.nil? ? @starting_direction = read_enum(Direction) : @starting_direction)
  end

  def write_world(world)
    if world.nil?
      write_boolean(false)
    else
      write_boolean(true)

      write_int(world.tick)
      write_int(world.tick_count)
      write_int(world.last_tick_index)
      write_int(world.width)
      write_int(world.height)
      write_players(world.players)
      write_cars(world.cars)
      write_projectiles(world.projectiles)
      write_bonuses(world.bonuses)
      write_oil_slicks(world.oil_slicks)
      write_string(world.map_name)
      write_enums_2d(world.tiles_x_y)
      write_ints_2d(world.waypoints)
      write_enum(world.starting_direction)
    end
  end

  def read_worlds
    world_count = read_int
    if world_count < 0
      return nil
    end

    worlds = []

    world_count.times do |_|
      worlds.push(read_world)
    end

    worlds
  end

  def write_worlds(worlds)
    if worlds.nil?
      write_int(-1)
    else
      write_int(worlds.length)

      worlds.each do |world|
        write_world(world)
      end
    end
  end

  def ensure_message_type(actual_type, expected_type)
    if actual_type != expected_type
      raise ArgumentError "Received wrong message [actual=#{actual_type}, expected=#{expected_type}]."
    end
  end

  def read_enum(enum_class)
    byte_array = read_bytes(SIGNED_BYTE_SIZE_BYTES)
    value = byte_array.unpack('c')[0]

    value >= 0 && value < enum_class::COUNT ? value : nil
  end

  def read_enums(enum_class)
    count = read_int
    if count < 0
      return nil
    end

    enums = []

    count.times do |_|
      enums.push(read_enum(enum_class))
    end

    enums
  end

  def read_enums_2d(enum_class)
    count = read_int
    if count < 0
      return nil
    end

    enums_2d = []

    count.times do |_|
      enums_2d.push(read_enums(enum_class))
    end

    enums_2d
  end

  def write_enum(value)
    write_bytes([value.nil? ? -1 : value].pack('c'))
  end

  def write_enums(enums)
    if enums.nil?
      write_int(-1)
    else
      write_int(enums.length)

      enums.each do |enum|
        write_enum(enum)
      end
    end
  end

  def write_enums_2d(enums_2d)
    if enums_2d.nil?
      write_enum(-1)
    else
      write_enum(enums_2d.length)

      enums_2d.each do |enums|
        write_enum(enums)
      end
    end
  end

  def read_string
    length = read_int
    if length == -1
      return nil
    end

    read_bytes(length)
  end

  def write_string(value)
    if value.nil?
      write_int(-1)
      return
    end

    write_int(value.length)
    write_bytes(value)
  end

  def read_boolean
    byte_array = read_bytes(SIGNED_BYTE_SIZE_BYTES)
    byte_array.unpack('c')[0] != 0
  end

  def write_boolean(value)
    write_bytes([value ? 1 : 0].pack('c'))
  end

  def read_int
    byte_array = read_bytes(INTEGER_SIZE_BYTES)
    byte_array.unpack('l' + BYTE_ORDER_FORMAT_STRING)[0]
  end

  def read_ints
    count = read_int
    if count < 0
      return nil
    end

    ints = []

    count.times do |_|
      ints.push(read_int)
    end

    ints
  end

  def read_ints_2d
    count = read_int
    if count < 0
      return nil
    end

    ints_2d = []

    count.times do |_|
      ints_2d.push(read_ints)
    end

    ints_2d
  end

  def write_int(value)
    write_bytes([value].pack('l' + BYTE_ORDER_FORMAT_STRING))
  end

  def write_ints(ints)
    if ints.nil?
      write_int(-1)
    else
      write_int(ints.length)

      ints.each do |int|
        write_int(int)
      end
    end
  end

  def write_ints_2d(ints_2d)
    if ints_2d.nil?
      write_int(-1)
    else
      write_int(ints_2d.length)

      ints_2d.each do |ints|
        write_int(ints)
      end
    end
  end

  def read_long
    byte_array = read_bytes(LONG_SIZE_BYTES)
    byte_array.unpack('q' + BYTE_ORDER_FORMAT_STRING)[0]
  end

  def write_long(value)
    write_bytes([value].pack('q' + BYTE_ORDER_FORMAT_STRING))
  end

  def read_double
    byte_array = read_bytes(DOUBLE_SIZE_BYTES)
    byte_array.unpack(LITTLE_ENDIAN_BYTE_ORDER ? 'E' : 'G')[0]
  end

  def write_double(value)
    write_bytes([value].pack(LITTLE_ENDIAN_BYTE_ORDER ? 'E' : 'G'))
  end

  def read_bytes(byte_count)
    byte_array = ''

    while byte_array.length < byte_count
      chunk = @socket.recv(byte_count - byte_array.length)

      if chunk.length == 0
        raise IOError "Can't read #{byte_count} bytes from input stream."
      end

      byte_array += chunk
    end

    byte_array
  end

  def write_bytes(byte_array)
    @socket.write(byte_array)
  end

  def close
    @socket.close
  end

  module MessageType
    UNKNOWN = 0
    GAME_OVER = 1
    AUTHENTICATION_TOKEN = 2
    TEAM_SIZE = 3
    PROTOCOL_VERSION = 4
    GAME_CONTEXT = 5
    PLAYER_CONTEXT = 6
    MOVES = 7
    COUNT = 8
  end
end