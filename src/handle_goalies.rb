require 'byebug'
require_relative './sort_goalies'
require_relative '../util/print_results'
require_relative '../util/find_team_name'

def handle_goalies input_arr
  all_goalies_with_recent_stats = []

  input_arr.each do |input|
    next if input.nil?

    goalie = input['player']
    name =  goalie['fullName']
    team = find_team_name(goalie['proTeamId'])
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
      team: team,
      games_played: games_played,
      saves: total_saves,
      wins: total_wins,
      losses: total_losses,
      goals_against: total_goals_against,
      points_scored: total_points_scored
    }

    all_goalies_with_recent_stats << goalie_with_recent_stats
  end

  sorted_goalies = sort_goalies(all_goalies_with_recent_stats)
  print_results(sorted_goalies.slice(0,15))
end
