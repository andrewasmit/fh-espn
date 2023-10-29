require 'byebug'
require_relative './sort_goalies'
require_relative './print_results'

def handle_goalies input_arr
  all_goalies_with_recent_stats = []

  input_arr.each do |input|
    next if input.nil?

    goalie = input['player']
    name =  goalie['fullName']
    # team = find_team_name(player['proTeamId'])
    last_six_games = goalie['stats'].slice(0,6)

    # Initialize Counter Variables
    games_played = 0
    total_saves = 0
    total_wins = 0
    total_losses = 0
    total_goals_against = 0
    total_points_scored = 0

    # Loop through each game to count points and averages
    last_six_games.each do |game|
      next if game['stats'] == {}

      # Target specific stats
      saves = game['stats']['6']
      wins = game['stats']['1']
      losses = game['stats']['2']
      goals_against = game['stats']['4']
      points_scored = game['appliedTotal']
      
      # Add each game's stats to the counters
      total_saves += saves 
      total_wins += wins
      total_losses += losses
      total_goals_against += goals_against
      total_points_scored += points_scored
      games_played += 1
    end

    # Create our object with the targeted data
  goalie_with_recent_stats = {
      name: name,
      # team: team,
      games_played: games_played,
      saves: total_saves,
      wins: total_wins,
      losses: total_losses,
      goals_against: total_goals_against,
      points_scored: total_points_scored
    }

    all_goalies_with_recent_stats << goalie_with_recent_stats
  end

  byebug
  sorted_goalies = sort_goalies(all_goalies_with_recent_stats)
  print_results(sorted_goalies.slice(0,15))
end


# Example Stats Game
# {
#   "appliedTotal"=>1.2000000000000002, *** Total Points Scored ***
#   "externalId"=>"401559351", 
#   "id"=>"05401559351", 
#   "proTeamId"=>24, 
#   "scoringPeriodId"=>18, 
#   "seasonId"=>2024, 
#   "statSourceId"=>0, 
#   "statSplitTypeId"=>5, 
#   "stats"=>{
#     "0"=>1.0,  
#     "1"=>0.0, *** WIN Game ***
#     "2"=>1.0,  *** Loss Game ***
#     "3"=>41.0, 
#     "4"=>5.0, *** Goals Against *** 
#     "6"=>36.0,  *** SAVES ***
#     "7"=>0.0, 
#     "8"=>3580.0, 
#     "9"=>0.0, 
#     "10"=>5.027932960893855, 
#     "11"=>0.878, *** Save Percentage ***
#     "12"=>0.0, 
#     "30"=>1.0,  
#     "35"=>0.0, 
#     "36"=>0.0, 
#     "37"=>0.0, 
#     "38"=>0.0, 
#     "39"=>0.0
#   }
# }

{"appliedTotal"=>0.20000000000000018, "externalId"=>"401559332", "id"=>"05401559332", "proTeamId"=>24, "scoringPeriodId"=>15, "seasonId"=>2024, "statSourceId"=>0, "statSplitTypeId"=>5, 
  "stats"=>{
    
    "0"=>0.0, 
    "1"=>0.0, 
    "2"=>1.0, 
    "3"=>18.0, 
    "4"=>2.0, 
    "6"=>16.0, 
    "7"=>0.0, 
    "8"=>2725.0, 
    "9"=>0.0, 
    "10"=>2.6422018348623855, 
    "11"=>0.889, 
    "12"=>0.0, 
    "30"=>1.0, 
    "35"=>0.0, 
    "36"=>0.0, 
    "37"=>0.0, 
    "38"=>0.0, 
    "39"=>0.0
  }
}