require 'sinatra'
require 'csv'
require 'pry'

def read_team_data
  players = []
  CSV.foreach('lackp_starting_rosters.csv', headers: true, header_converters: :symbol) do |row|
    players << row.to_hash
  end
  players
end

get '/' do
  @all_players = read_team_data

  @teams = []
  @all_players.each do |player_hash|
    if !@teams.include?(player_hash[:team])
      @teams << player_hash[:team]
    end
  end

  erb :index
end

get '/teams/:team_name' do
  # @players = read_team_data
  # @players = @players.find do |player|
    # player[:first_name] == params[:first_name]
  "got here for team #{params[:team_name]}"
  end
# erb :'teams/teampage'
end
