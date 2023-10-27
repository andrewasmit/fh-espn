require 'byebug'

def handle_players input_arr
  all_players_with_recent_stats = []

  input_arr.each do |input|
    player = input['player']
    name =  player['fullName']
    team = player['proTeamId']
    last_five_games = player['stats'].slice(0,5)

    # Initialize Counter Variables
    total_goals_scored = 0
    total_assists_scored = 0
    multi_point_nights = 0
    total_points_scored = 0
    category_point_games = 0
    bad_games = 0

    # Loop through each game to count points and averages
    last_five_games.each do |game|
      # Target specific stats
      points_scored = game['appliedTotal']
      goals_scored = game['stats']['13']
      assists_scored = game['stats']['14']
      
      # Add each game's stats to the counters
      total_goals_scored += goals_scored
      total_assists_scored += assists_scored
      total_points_scored += points_scored
      multi_point_nights += 1 if (goals_scored > 0 && assists_scored > 0)
      category_point_games += 1 if (goals_scored == 0 && assists_scored == 0 && points_scored >= 3.0)
      bad_games += 1 if (goals_scored == 0 && assists_scored == 0 && points_scored < 3.0)
    end

    puts "In the last 5 games, #{name} has scored #{total_goals_scored} goals, #{total_assists_scored} assists, and accumulated #{total_points_scored} fantasy points."
    puts "#{name} had #{multi_point_nights} games with multiple goals/assists."
    puts "#{name} had #{category_point_games} games where he scored at least 3 fantasy points without scoring a goal or assist."
    puts "#{name} had #{bad_games} games where he failed to score at least 3 fantasy points."
    puts "#{name} plays for team # #{team}"
    player_with_recent_stats = {
      name: name,
      goals: total_goals_scored,
      assists: total_assists_scored,
      total_points: total_assists_scored,
      multi_point_nights: multi_point_nights,
      category_point_games: category_point_games,
      bad_games: bad_games
    }
    all_players_with_recent_stats << player_with_recent_stats
  end
  puts all_players_with_recent_stats
end


# Target Data for each player's last ten games
# {
#   name: "Seth Jarvis",
#   goals: 4,
#   assists: 2,
#   total_points: 34.6,
#   multi_point_nights: 1,
#   category_point_games_games: 1,
#   bad_games: 1
# }