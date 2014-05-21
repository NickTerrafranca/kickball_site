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


get('/') do
  @all_players = read_team_data

  @teams = []
  @all_players.each do |player_hash|
    if !@teams.include?(player_hash[:team])
      @teams << player_hash[:team]
    end
  end

  erb :index
end

get('/teams/:team_name') do
  @team_name = params[:team_name]
  @all_players = read_team_data
  @roster = []

  # TODO: get a list of players into @roster that belong to this team

  @all_players.each do |team|
    if !@roster.include?(@team_name)
      @roster << team[:first_name] << team[:last_name]
    end
    "#{@roster}"
    # binding.pry


  erb :show
  end
end


# get('/teams/:team_name') do
# "got here for team #{params[:team_name]}"
# end
