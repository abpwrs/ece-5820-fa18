class WrongNumberOfPlayersError < StandardError
end
class NoSuchStrategyError < StandardError
end
class InvalidTournamentStructure < StandardError
end

def rps_game_winner(game)
  # Input Validation
  raise WrongNumberOfPlayersError unless game.length == 2
  game.each do |entry|
    raise NoSuchStrategyError unless entry[1] =~ /^[rps]$/i
    raise ArgumentError unless entry.size == 2
  end

  # game logic
  strategy_hash = { r: 's', p: 'r', s: 'p' }
  game[0][1].casecmp(strategy_hash[game[1][1].downcase.to_sym]).zero? ? game[1] : game[0]
end

def rps_tournament_winner(tournament)
  # input validation
  raise InvalidTournamentStructure unless tournament.length == 2
  # game logic expanded for readability
  p1 = tournament[0][0].respond_to?(:each) ? rps_tournament_winner(tournament[0]) : tournament[0]
  p2 = tournament[1][0].respond_to?(:each) ? rps_tournament_winner(tournament[1]) : tournament[1]
  rps_game_winner([p1, p2])
end
