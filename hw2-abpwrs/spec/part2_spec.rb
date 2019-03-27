require 'part2.rb'
require 'rspec.rb'

# 30 pts for part A
describe '#rps_game_winner' do
  it 'must be defined [0 point]' do
    expect {rps_game_winner([%w[X P], %w[Y S]])}.not_to raise_error
  end

  # this is given for free in the outline
  it 'raises WrongNumberOfPlayersError if there are not exactly two players [1 point]' do
    expect {rps_game_winner([%w[Allen S]])}.to raise_error(WrongNumberOfPlayersError), 'No error raised for incorrect number of players'
    expect {rps_game_winner([%w[Allen S], %w[Joe R], %w[Sally p]])}.to raise_error(WrongNumberOfPlayersError), 'No error raised for incorrect number of players'

  end

  it 'must reject invalid strategies' do
    expect {rps_game_winner([%w[Alice T], %w[Bob S]])}.to raise_error(NoSuchStrategyError)
    expect {rps_game_winner([%w[Alice S], %w[Bob Q]])}.to raise_error(NoSuchStrategyError)
    expect {rps_game_winner([%w[Alice 5], %w[Bob S]])}.to raise_error(NoSuchStrategyError)
    expect {rps_game_winner([%w[Alice SR], %w[Bob S]])}.to raise_error(NoSuchStrategyError)
    expect {rps_game_winner([%w[Alice S], %w[Bob STRATEGY]])}.to raise_error(NoSuchStrategyError)
    expect {rps_game_winner([%w[Alice S], %w[Bob $]])}.to raise_error(NoSuchStrategyError)
  end

  it 'must accept all valid strategies' do
    expect {rps_game_winner([%w[Alice R], %w[Bob S]])}.not_to raise_error
    expect {rps_game_winner([%w[Alice P], %w[Bob R]])}.not_to raise_error
    expect {rps_game_winner([%w[Alice S], %w[Bob P]])}.not_to raise_error
  end

  it 'must be case insensitive of strategies' do
    expect {rps_game_winner([%w[Alice p], %w[Bob s]])}.not_to raise_error
    expect {rps_game_winner([%w[Alice r], %w[Bob p]])}.not_to raise_error
    expect {rps_game_winner([%w[Alice s], %w[Bob r]])}.not_to raise_error
  end

  it 'must return the correct winner' do
    # clear winner
    expect(rps_game_winner([%w[Alice p], %w[Bob r]])).to eq(%w[Alice p])
    expect(rps_game_winner([%w[Alice s], %w[Bob r]])).to eq(%w[Bob r])
    expect(rps_game_winner([%w[Alice s], %w[Bob p]])).to eq(%w[Alice s])
    # ties
    expect(rps_game_winner([%w[Alice s], %w[Bob s]])).to eq(%w[Alice s])
    expect(rps_game_winner([%w[Alice p], %w[Bob p]])).to eq(%w[Alice p])
    expect(rps_game_winner([%w[Alice r], %w[Bob r]])).to eq(%w[Alice r])

  end

end

# 70 pts for part B
describe '#rps_tournament_winner' do
  it 'must be defined' do
    expect(-> {rps_tournament_winner([%w[X P], %w[Y S]])}).not_to raise_error
  end

  it 'must return the correct winner' do
    expect(rps_tournament_winner([[[%w[a P], %w[b S]], [%w[c R], %w[d S]]], [[%w[e P], %w[f S]], [%w[g S], %w[h S]]]])).to eq(%w[c R])
    expect(rps_tournament_winner([[[%w[a P], %w[b S]], [%w[c R], %w[d P]]], [[%w[e P], %w[f S]], [%w[g S], %w[h S]]]])).to eq(%w[b S])
    expect(rps_tournament_winner([[[%w[a S], %w[b S]], [%w[c S], %w[d S]]], [[%w[e S], %w[f S]], [%w[g S], %w[h S]]]])).to eq(%w[a S])
    expect(rps_tournament_winner([[[%w[a P], %w[b S]], [%w[c R], %w[d S]]], [[%w[e P], %w[f S]], [%w[g S], %w[h R]]]])).to eq(%w[c R])
    expect(rps_tournament_winner([[[%w[a R], %w[b S]], [%w[c R], %w[d S]]], [[%w[e P], %w[f S]], [%w[g S], %w[h S]]]])).to eq(%w[a R])
  end

  # I know that this is not required, but I think it provides a more robust solution to the problem
  it 'must allow for a bye' do
    expect(rps_tournament_winner([[[%w[a P], %w[b S]], [%w[c R], %w[d S]]], [[%w[e P], %w[f S]], %w[g S]]])).to eq(%w[c R])
    expect(rps_tournament_winner([[%w[a P], [%w[b R], %w[c S]]], [[%w[d P], %w[e S]], [%w[f S], %w[g S]]]])).to eq(%w[e S])
    expect(rps_tournament_winner([[[%w[a P], %w[b S]], %w[c R]], [[%w[d P], %w[e S]], [%w[f S], %w[g S]]]])).to eq(%w[c R])
  end

  it 'must have the correct number of players in each game' do
    expect {rps_tournament_winner([[[%w[a P], %w[b S], %w[jimmy p]], [%w[c R], %w[d S]]], [[%w[e P], %w[f S]], [%w[g S], %w[h S]]]])}.to raise_error(InvalidTournamentStructure)
  end

  it 'must only allow valid strategies' do
    expect {rps_tournament_winner([[[%w[a 8], %w[b S]], [%w[c R], %w[d S]]], [[%w[e P], %w[f S]], [%w[g S], %w[h S]]]])}.to raise_error(NoSuchStrategyError)
    expect {rps_tournament_winner([[[%w[a S], %w[b $]], [%w[c R], %w[d S]]], [[%w[e P], %w[f S]], [%w[g S], %w[h S]]]])}.to raise_error(NoSuchStrategyError)
    expect {rps_tournament_winner([[[%w[a S], %w[b S]], [%w[c Q], %w[d S]]], [[%w[e P], %w[f S]], [%w[g S], %w[h S]]]])}.to raise_error(NoSuchStrategyError)
    expect {rps_tournament_winner([[[%w[a S], %w[b S]], [%w[c R], %w[d STRATAGEY]]], [[%w[e P], %w[f S]], [%w[g S], %w[h S]]]])}.to raise_error(NoSuchStrategyError)
    expect {rps_tournament_winner([[[%w[a S], %w[b S]], [%w[c R], %w[d S]]], [[%w[e PLEASE LET ME WIN], %w[f S]], [%w[g S], %w[h S]]]])}.to raise_error(NoSuchStrategyError)

  end
end
