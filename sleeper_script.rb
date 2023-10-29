# External Dependencies
require 'uri'
require 'http'
require 'byebug'
require 'dotenv'
require_relative './util/swap_quotes'
require_relative './util/handle_skaters'
require_relative './util/handle_goalies'
Dotenv.load('./.env')


# Local Typings 
players_uri = URI("https://lm-api-reads.fantasy.espn.com/apis/v3/games/fhl/seasons/2024/segments/0/leagues/#{ENV['LEAGUE_ID']}?scoringPeriodId=17&view=kona_player_info")

puts "What position do you want to target?"
puts "0: Center"
puts "1: Left Wing"
puts "2: Right Wing"
puts "3: All Forwards (C, LW, RW)"
puts "4: Defenseman"
puts "5: Goaltenders"
puts "6: All Skaters (F or D)"

position_filter = gets.chomp

filter = "{'players':{'filterStatus':{'value':['FREEAGENT','WAIVERS']},'filterSlotIds':{'value': [#{position_filter}]},'filterRanksForScoringPeriodIds':{'value':[17]},'sortPercChanged':{'sortPriority':1,'sortAsc':false}, 'sortPercOwned':{'sortPriority':2,'sortAsc':false}, 'limit': 150,'filterStatsForTopScoringPeriodIds':{'value':10,'additionalValue':['002024','102024','002023','012024','022024','032024','042024']}}}"
filter = swap_quotes(filter)

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

# handle_players(players) if position_filter != '5'
# puts 'Handle Goalies' if position_filter == '5'

position_filter != '5' ? handle_skaters(players) : handle_goalies(players)