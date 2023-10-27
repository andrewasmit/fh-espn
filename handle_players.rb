require 'byebug'

def handle_players input_arr
  all_players_with_recent_stats = []

  input_arr.each do |input|
    player = input['player']
    name =  player['fullName']
    team = player['proTeamId']
    last_six_games = player['stats'].slice(0,6)

    # Initialize Counter Variables
    games_played = 0
    total_goals_scored = 0
    total_assists_scored = 0
    multi_point_nights = 0
    total_points_scored = 0
    category_point_games = 0
    bad_games = 0

    # Loop through each game to count points and averages
    last_six_games.each do |game|
      # byebug
      break if game['stats'] == {}
      # Target specific stats
      points_scored = game['appliedTotal']
      goals_scored = game['stats']['13']
      assists_scored = game['stats']['14']
      games_played += 1
      
      # Add each game's stats to the counters
      total_goals_scored += goals_scored
      total_assists_scored += assists_scored
      total_points_scored += points_scored
      multi_point_nights += 1 if (goals_scored > 0 && assists_scored > 0)
      category_point_games += 1 if (goals_scored == 0 && assists_scored == 0 && points_scored >= 3.0)
      bad_games += 1 if (goals_scored == 0 && assists_scored == 0 && points_scored < 2.5)
    end

    player_with_recent_stats = {
      name: name,
      games_played: games_played,
      goals: total_goals_scored,
      assists: total_assists_scored,
      total_points: total_points_scored,
      average_ppg: (total_points_scored / games_played),
      multi_point_nights: multi_point_nights,
      category_point_games: category_point_games,
      bad_games: bad_games
    }

    all_players_with_recent_stats << player_with_recent_stats
  end

  puts all_players_with_recent_stats
end
