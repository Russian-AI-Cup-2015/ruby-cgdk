# noinspection RubyInstanceVariableNamingConvention,RubyParameterNamingConvention,RubyTooManyInstanceVariablesInspection
class Game
  # @return [Integer]
  attr_reader :random_seed

  # @return [Integer]
  attr_reader :tick_count

  # @return [Integer]
  attr_reader :world_width

  # @return [Integer]
  attr_reader :world_height

  # @return [Float]
  attr_reader :track_tile_size

  # @return [Float]
  attr_reader :track_tile_margin

  # @return [Integer]
  attr_reader :lap_count

  # @return [Integer]
  attr_reader :lap_tick_count

  # @return [Integer]
  attr_reader :initial_freeze_duration_ticks

  # @return [Float]
  attr_reader :burning_time_duration_factor

  # @return [Array<Integer>, NilClass]
  attr_reader :finish_track_scores

  # @return [Integer]
  attr_reader :finish_lap_score

  # @return [Float]
  attr_reader :lap_waypoints_summary_score_factor

  # @return [Float]
  attr_reader :car_damage_score_factor

  # @return [Integer]
  attr_reader :car_elimination_score

  # @return [Float]
  attr_reader :car_width

  # @return [Float]
  attr_reader :car_height

  # @return [Float]
  attr_reader :car_engine_power_change_per_tick

  # @return [Float]
  attr_reader :car_wheel_turn_change_per_tick

  # @return [Float]
  attr_reader :car_angular_speed_factor

  # @return [Float]
  attr_reader :car_movement_air_friction_factor

  # @return [Float]
  attr_reader :car_rotation_air_friction_factor

  # @return [Float]
  attr_reader :car_lengthwise_movement_friction_factor

  # @return [Float]
  attr_reader :car_crosswise_movement_friction_factor

  # @return [Float]
  attr_reader :car_rotation_friction_factor

  # @return [Integer]
  attr_reader :throw_projectile_cooldown_ticks

  # @return [Integer]
  attr_reader :use_nitro_cooldown_ticks

  # @return [Integer]
  attr_reader :spill_oil_cooldown_ticks

  # @return [Float]
  attr_reader :nitro_engine_power_factor

  # @return [Integer]
  attr_reader :nitro_duration_ticks

  # @return [Integer]
  attr_reader :car_reactivation_time_ticks

  # @return [Float]
  attr_reader :buggy_mass

  # @return [Float]
  attr_reader :buggy_engine_forward_power

  # @return [Float]
  attr_reader :buggy_engine_rear_power

  # @return [Float]
  attr_reader :jeep_mass

  # @return [Float]
  attr_reader :jeep_engine_forward_power

  # @return [Float]
  attr_reader :jeep_engine_rear_power

  # @return [Float]
  attr_reader :bonus_size

  # @return [Float]
  attr_reader :bonus_mass

  # @return [Integer]
  attr_reader :pure_score_amount

  # @return [Float]
  attr_reader :washer_radius

  # @return [Float]
  attr_reader :washer_mass

  # @return [Float]
  attr_reader :washer_initial_speed

  # @return [Float]
  attr_reader :washer_damage

  # @return [Float]
  attr_reader :side_washer_angle

  # @return [Float]
  attr_reader :tire_radius

  # @return [Float]
  attr_reader :tire_mass

  # @return [Float]
  attr_reader :tire_initial_speed

  # @return [Float]
  attr_reader :tire_damage_factor

  # @return [Float]
  attr_reader :tire_disappear_speed_factor

  # @return [Float]
  attr_reader :oil_slick_initial_range

  # @return [Float]
  attr_reader :oil_slick_radius

  # @return [Integer]
  attr_reader :oil_slick_lifetime

  # @return [Integer]
  attr_reader :max_oiled_state_duration_ticks

  # @param [Integer] random_seed
  # @param [Integer] tick_count
  # @param [Integer] world_width
  # @param [Integer] world_height
  # @param [Float] track_tile_size
  # @param [Float] track_tile_margin
  # @param [Integer] lap_count
  # @param [Integer] lap_tick_count
  # @param [Integer] initial_freeze_duration_ticks
  # @param [Float] burning_time_duration_factor
  # @param [Array<Integer>, NilClass] finish_track_scores
  # @param [Integer] finish_lap_score
  # @param [Float] lap_waypoints_summary_score_factor
  # @param [Float] car_damage_score_factor
  # @param [Integer] car_elimination_score
  # @param [Float] car_width
  # @param [Float] car_height
  # @param [Float] car_engine_power_change_per_tick
  # @param [Float] car_wheel_turn_change_per_tick
  # @param [Float] car_angular_speed_factor
  # @param [Float] car_movement_air_friction_factor
  # @param [Float] car_rotation_air_friction_factor
  # @param [Float] car_lengthwise_movement_friction_factor
  # @param [Float] car_crosswise_movement_friction_factor
  # @param [Float] car_rotation_friction_factor
  # @param [Integer] throw_projectile_cooldown_ticks
  # @param [Integer] use_nitro_cooldown_ticks
  # @param [Integer] spill_oil_cooldown_ticks
  # @param [Float] nitro_engine_power_factor
  # @param [Integer] nitro_duration_ticks
  # @param [Integer] car_reactivation_time_ticks
  # @param [Float] buggy_mass
  # @param [Float] buggy_engine_forward_power
  # @param [Float] buggy_engine_rear_power
  # @param [Float] jeep_mass
  # @param [Float] jeep_engine_forward_power
  # @param [Float] jeep_engine_rear_power
  # @param [Float] bonus_size
  # @param [Float] bonus_mass
  # @param [Integer] pure_score_amount
  # @param [Float] washer_radius
  # @param [Float] washer_mass
  # @param [Float] washer_initial_speed
  # @param [Float] washer_damage
  # @param [Float] side_washer_angle
  # @param [Float] tire_radius
  # @param [Float] tire_mass
  # @param [Float] tire_initial_speed
  # @param [Float] tire_damage_factor
  # @param [Float] tire_disappear_speed_factor
  # @param [Float] oil_slick_initial_range
  # @param [Float] oil_slick_radius
  # @param [Integer] oil_slick_lifetime
  # @param [Integer] max_oiled_state_duration_ticks
  def initialize(random_seed, tick_count, world_width, world_height, track_tile_size, track_tile_margin, lap_count,
                 lap_tick_count, initial_freeze_duration_ticks, burning_time_duration_factor, finish_track_scores,
                 finish_lap_score, lap_waypoints_summary_score_factor, car_damage_score_factor, car_elimination_score,
                 car_width, car_height, car_engine_power_change_per_tick, car_wheel_turn_change_per_tick,
                 car_angular_speed_factor, car_movement_air_friction_factor, car_rotation_air_friction_factor,
                 car_lengthwise_movement_friction_factor, car_crosswise_movement_friction_factor,
                 car_rotation_friction_factor, throw_projectile_cooldown_ticks, use_nitro_cooldown_ticks,
                 spill_oil_cooldown_ticks, nitro_engine_power_factor, nitro_duration_ticks, car_reactivation_time_ticks,
                 buggy_mass, buggy_engine_forward_power, buggy_engine_rear_power, jeep_mass, jeep_engine_forward_power,
                 jeep_engine_rear_power, bonus_size, bonus_mass, pure_score_amount, washer_radius, washer_mass,
                 washer_initial_speed, washer_damage, side_washer_angle, tire_radius, tire_mass, tire_initial_speed,
                 tire_damage_factor, tire_disappear_speed_factor, oil_slick_initial_range, oil_slick_radius,
                 oil_slick_lifetime, max_oiled_state_duration_ticks)
    @random_seed = random_seed
    @tick_count = tick_count
    @world_width = world_width
    @world_height = world_height
    @track_tile_size = track_tile_size
    @track_tile_margin = track_tile_margin
    @lap_count = lap_count
    @lap_tick_count = lap_tick_count
    @initial_freeze_duration_ticks = initial_freeze_duration_ticks
    @burning_time_duration_factor = burning_time_duration_factor
    @finish_track_scores = finish_track_scores
    @finish_lap_score = finish_lap_score
    @lap_waypoints_summary_score_factor = lap_waypoints_summary_score_factor
    @car_damage_score_factor = car_damage_score_factor
    @car_elimination_score = car_elimination_score
    @car_width = car_width
    @car_height = car_height
    @car_engine_power_change_per_tick = car_engine_power_change_per_tick
    @car_wheel_turn_change_per_tick = car_wheel_turn_change_per_tick
    @car_angular_speed_factor = car_angular_speed_factor
    @car_movement_air_friction_factor = car_movement_air_friction_factor
    @car_rotation_air_friction_factor = car_rotation_air_friction_factor
    @car_lengthwise_movement_friction_factor = car_lengthwise_movement_friction_factor
    @car_crosswise_movement_friction_factor = car_crosswise_movement_friction_factor
    @car_rotation_friction_factor = car_rotation_friction_factor
    @throw_projectile_cooldown_ticks = throw_projectile_cooldown_ticks
    @use_nitro_cooldown_ticks = use_nitro_cooldown_ticks
    @spill_oil_cooldown_ticks = spill_oil_cooldown_ticks
    @nitro_engine_power_factor = nitro_engine_power_factor
    @nitro_duration_ticks = nitro_duration_ticks
    @car_reactivation_time_ticks = car_reactivation_time_ticks
    @buggy_mass = buggy_mass
    @buggy_engine_forward_power = buggy_engine_forward_power
    @buggy_engine_rear_power = buggy_engine_rear_power
    @jeep_mass = jeep_mass
    @jeep_engine_forward_power = jeep_engine_forward_power
    @jeep_engine_rear_power = jeep_engine_rear_power
    @bonus_size = bonus_size
    @bonus_mass = bonus_mass
    @pure_score_amount = pure_score_amount
    @washer_radius = washer_radius
    @washer_mass = washer_mass
    @washer_initial_speed = washer_initial_speed
    @washer_damage = washer_damage
    @side_washer_angle = side_washer_angle
    @tire_radius = tire_radius
    @tire_mass = tire_mass
    @tire_initial_speed = tire_initial_speed
    @tire_damage_factor = tire_damage_factor
    @tire_disappear_speed_factor = tire_disappear_speed_factor
    @oil_slick_initial_range = oil_slick_initial_range
    @oil_slick_radius = oil_slick_radius
    @oil_slick_lifetime = oil_slick_lifetime
    @max_oiled_state_duration_ticks = max_oiled_state_duration_ticks
  end
end