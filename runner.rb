require './my_strategy'
require './remote_process_client'

class Runner
  def initialize
    if ARGV.length == 3
      @remote_process_client = RemoteProcessClient::new(ARGV[0], ARGV[1].to_i)
      @token = ARGV[2]
    else
      @remote_process_client = RemoteProcessClient::new('127.0.0.1', 31001)
      @token = '0000000000000000'
    end
  end

  def run
    begin
      @remote_process_client.write_token_message(@token)
      team_size = @remote_process_client.read_team_size_message
      @remote_process_client.write_protocol_version_message
      game = @remote_process_client.read_game_context_message

      strategies = []

      team_size.times do |_|
        strategies.push(MyStrategy::new)
      end

      while (player_context = @remote_process_client.read_player_context_message) != nil
        player_cars = player_context.cars
        break if player_cars == nil || player_cars.length != team_size

        moves = []

        team_size.times do |car_index|
          player_car = player_cars[car_index]

          move = Move::new
          moves.push(move)
          strategies[player_car.teammate_index].move(player_car, player_context.world, game, move)
        end

        @remote_process_client.write_moves_message(moves)
      end
    ensure
      @remote_process_client.close
    end
  end
end

Runner.new.run