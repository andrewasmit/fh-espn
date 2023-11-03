require 'byebug'
require_relative './sort_skaters'
require_relative '../util/print_results'
require_relative '../util/find_team_name'
Dotenv.load('./.env')

def handle_skaters input_arr
  all_skaters_with_recent_stats = []

  input_arr.each do |input|
    next if input.nil?

    skater = input['player']
    name =  skater['fullName']
    team = find_team_name(skater['proTeamId'])
    last_ten_games = skater['stats'].slice(0,10)

    # Initialize Counter Variables
    games_played = 0
    total_goals_scored = 0
    total_assists_scored = 0
    multi_point_nights = 0
    total_points_scored = 0
    category_point_games = 0
    games_with_points = 0
    bad_games = 0

    # Loop through each game to count points and averages
    last_ten_games.each do |game|
      next if game['stats'] == {} || game['seasonId'] != ENV['SEASON_ID'].to_i

      # Target specific stats
      points_scored = game['appliedTotal']
      goals_scored = game['stats']['13']
      assists_scored = game['stats']['14']
      games_played += 1
      
      # Add each game's stats to the counters
      total_goals_scored += goals_scored
      total_assists_scored += assists_scored
      total_points_scored += points_scored
      games_with_points += 1 if (goals_scored > 0 || assists_scored > 0)
      multi_point_nights += 1 if (goals_scored > 0 && assists_scored > 0)
      category_point_games += 1 if (goals_scored == 0 && assists_scored == 0 && points_scored >= 3.0)
      bad_games += 1 if (goals_scored == 0 && assists_scored == 0 && points_scored < 2.5)
    end

    # Create our object with the targeted data
    skater_with_recent_stats = {
      name: name,
      team: team,
      games_played: games_played,
      games_with_points: games_with_points,
      goals: total_goals_scored,
      assists: total_assists_scored,
      total_points: total_points_scored,
      average_ppg: total_points_scored > 0 ? (total_points_scored / games_played) : 0,
      multi_point_nights: multi_point_nights,
      category_point_games: category_point_games,
      bad_games: bad_games
    }

    all_skaters_with_recent_stats << skater_with_recent_stats
  end

  sorted_skaters = sort_skaters(all_skaters_with_recent_stats)
  print_results(sorted_skaters.slice(0,15))
end
