# External Dependencies
require 'uri'
require 'http'
require 'cgi'
require 'byebug'
require 'dotenv'
Dotenv.load('./.env')

# Local Typings
# goalies_uri = URI("https://lm-api-reads.fantasy.espn.com/apis/v3/games/fhl/seasons/2024/segments/0/leagues/#{ENV['LEAGUE_ID']}?view=kona_player_info")
players_uri = URI("https://lm-api-reads.fantasy.espn.com/apis/v3/games/fhl/seasons/2024/segments/0/leagues/#{ENV['LEAGUE_ID']}?scoringPeriodId=17&view=kona_player_info")
cookies = CGI::Cookie.new(ENV['ESPN_COOKIE']).to_s.sub(/; path=$/, '')

headers = {
  :origin => "https://fantasy.espn.com",
  :cookie => cookies,
  :accept => 'application/json',
  :Accept => '*/*',
  :authority => "lm-api-reads.fantasy.espn.com",
  :connection => 'keep-alive',
  :user_agent => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36",
  
  # "X-Fantasy-Filter" => {
  #   "players" => {
  #     "filterStatus" => {
  #       "value" => ["FREEAGENT", "WAIVERS"]
  #     },
  #     "filterSlotIds" => {
  #       "value" => [4]
  #     },
  #     "filterRanksForScoringPeriodIds" => {
  #       "value" => [17]
  #     },
  #     "limit" => 50,
  #     "offset" => 0,
  #     "sortPercChanged" => {
  #       "sortAsc" => false,
  #       "sortPriority" => 1
  #     },
  #     "sortDraftRanks" => {
  #       "sortPriority" => 100,
  #       "sortAsc" => true,
  #       "value" => "STANDARD"
  #     },
  #     "filterRanksForRankTypes" => {
  #       "value" => ["STANDARD"]
  #     },
  #     "filterStatsForTopScoringPeriodIds" => {
  #       "value" => 5,
  #       "additionalValue" => [
  #         "002024", "102024", "002023", "012024", "022024", "032024", "042024"
  #       ]
  #     }
  #   }
  # }
}

# GET raw data
# goalies_res = HTTP.get(goalies_uri, :headers => headers)
players_res = HTTP.get(players_uri, :headers => headers)

players = players_res.body
# byebug
puts players
# if players.code == 200
