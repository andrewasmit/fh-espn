# External Dependencies
require 'uri'
require 'http'
require 'byebug'
require_relative './get_date'

def get_games_by_date
  today = get_todays_date()

  uri = "https://site.api.espn.com/apis/fantasy/v2/games/fhl/games?useMap=true&dates=#{today}&pbpOnly=true"
  
  res = HTTP.get(uri)
  games_by_date = res.parse['events']
  
  ids_of_teams_with_games = []
  games_by_date.each do |game|
    game['competitors'].each do |team|
      ids_of_teams_with_games << team['id'].to_i
    end
  end

  "'filterProTeamIds':{'value':#{ids_of_teams_with_games}},"
end
