require 'sinatra'
require 'csv'

def read_team_data
  players = []
  CSV.foreach('lackp_starting_rosters.csv', headers: true, header_converters: :symbol) do |row|
    players << row.to_hash
  end
  players
end

get('/') do
  all_players = read_team_data
  @teams = []
  @player_position = []
  all_players.each do |player_hash|

    if !@teams.include?(player_hash[:team])
      @teams << player_hash[:team]
    end

    if !@player_position.include?(player_hash[:position])
      @player_position << player_hash[:position]
    end
  end
  erb :index
end

get('/teams/:team_name') do
  team_name = params[:team_name]
  all_players = read_team_data
  @roster = []
  all_players.each do |player|

    if player[:team] == team_name
      @roster << player
    end
    @roster
  end
  erb :show
end


get('/positions/:position') do
  position = params[:position]
  all_players = read_team_data
  @player_positions = []
  all_players.each do |player|

    if player[:position] == position
      @player_positions  << player
    end
    @player_positions
  end
    erb :position
end
