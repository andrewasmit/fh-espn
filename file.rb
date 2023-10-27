# External Dependencies
require 'uri'
require 'http'
require 'byebug'
require 'dotenv'
Dotenv.load('./.env')


# Local Typings 
players_uri = URI("https://lm-api-reads.fantasy.espn.com/apis/v3/games/fhl/seasons/2024/segments/0/leagues/#{ENV['LEAGUE_ID']}?scoringPeriodId=17&view=kona_player_info")

headers = {
  :origin => "https://fantasy.espn.com",
  :cookie => ENV['ESPN_COOKIE'],
  :accept => 'application/json',
  :Accept => '*/*',
  :authority => "lm-api-reads.fantasy.espn.com",
  :connection => 'keep-alive',
  :user_agent => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36",
  
  "X-Fantasy-Filter" => '{"players":{"filterStatus":{"value":["FREEAGENT","WAIVERS"]},"filterSlotIds":{"value":[2]},"filterRanksForScoringPeriodIds":{"value":[17]},"sortPercChanged":{"sortPriority":1,"sortAsc":false}, "sortPercOwned":{"sortPriority":2,"sortAsc":false}, "limit": 5,"filterStatsForTopScoringPeriodIds":{"value":5,"additionalValue":["002024","102024","002023","012024","022024","032024","042024"]}}}'
}

# GET raw data
players_res = HTTP.get(players_uri, :headers => headers)
players = players_res.body

puts players if players_res.code == 200
