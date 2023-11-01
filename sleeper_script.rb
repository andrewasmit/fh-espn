# External Dependencies
require 'uri'
require 'http'
require 'byebug'
require 'dotenv'
require_relative './util/swap_quotes'
require_relative './util/get_games_by_date'
require_relative './src/handle_skaters'
require_relative './src/handle_goalies'
require_relative './src/user_input'
Dotenv.load('./.env')

# Local Typings 
players_uri = URI("https://lm-api-reads.fantasy.espn.com/apis/v3/games/fhl/seasons/2024/segments/0/leagues/#{ENV['LEAGUE_ID']}?scoringPeriodId=17&view=kona_player_info")

filter = get_user_input()

headers = {
  :origin => "https://fantasy.espn.com",
  :cookie => ENV['ESPN_COOKIE'],
  :accept => 'application/json',
  :Accept => '*/*',
  :authority => "lm-api-reads.fantasy.espn.com",
  :connection => 'keep-alive',
  :user_agent => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36",
  
  "X-Fantasy-Filter" => filter
}

# GET raw data
players_res = HTTP.get(players_uri, :headers => headers)
players = players_res.parse["players"]

is_goalie_search = players[0]['player']['defaultPositionId'] == 5

is_goalie_search ?  handle_goalies(players) : handle_skaters(players)