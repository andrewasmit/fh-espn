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
  
  "X-Fantasy-Filter" => '{"players":{"filterStatus":{"value":["FREEAGENT","WAIVERS"]},"filterSlotIds":{"value":[2]},"filterRanksForScoringPeriodIds":{"value":[17]},"sortPercChanged":{"sortPriority":1,"sortAsc":false}, "sortPercOwned":{"sortPriority":2,"sortAsc":false}, "limit":5,"filterStatsForTopScoringPeriodIds":{"value":5,"additionalValue":["002024","102024","002023","012024","022024","032024","042024"]}}}'

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
players_res = HTTP.get(players_uri, :headers => headers)

players = players_res.body
byebug
puts players
# if players.code == 200



# RAW version of cookie in Postman
# SWID={CF9F764C-7956-4BA0-A455-D6898B32183A}; espn_s2=AEC14VgScItZfJAGC2iJn3hpmsdS8cjWYLRPLKstorxB7O%2FU3gt60V09qKG7sDY6IuYznGWqKh7BuW0hU42do3Sapg1F%2FrP9eUIbrFU22Qte3jwgkwBuTMjuvbqS9rvhhXtQSJ1tGHSy75rFOqZHoclZzdp6mXLmRFG3orsYqUEkm%2FeFPVm8xi9GwboJF7WcLzc5Voi3NQFl3zk86RHDFSwQ2iZcz5bO%2FikQv9l4APAr%2Fs%2FXOJSf%2F4J5poEqss6mOQJnTwe3BtAAolbxdi3bLMgz;

# RAW version of X-Fantasy-Filter in Postman
# "{"players":{"filterStatus":{"value":["FREEAGENT","WAIVERS"]},"filterSlotIds":{"value":[2]},"filterRanksForScoringPeriodIds":{"value":[17]},"sortPercChanged":{"sortPriority":1,"sortAsc":false}, "sortPercOwned":{"sortPriority":2,"sortAsc":false}, "limit":5,"filterStatsForTopScoringPeriodIds":{"value":5,"additionalValue":["002024","102024","002023","012024","022024","032024","042024"]}}}