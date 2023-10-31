def sort_goalies all_goalies
  sorted_goalies = all_goalies.sort do |a, b|

    result = b[:games_played] <=> a[:games_played]

    # Sort by wins/games_played ratio (higher is better)
    ratio_a = (a[:games_played] != 0) ? (a[:wins].to_f / a[:games_played]) : 0
    ratio_b = (b[:games_played] != 0) ? (b[:wins].to_f / b[:games_played]) : 0
    result = ratio_b <=> ratio_a  # Reverse order for higher priority

    result = -1 if b[:games_played] == 0

    # If wins to games_played ratio is the same, sort by points_scored (higher is better)
    result = b[:points_scored] <=> a[:points_scored] if result == 0
  
    # If points_scored are also the same, sort by saves (higher is better)
    result = b[:saves] <=> a[:saves] if result == 0
  
    # If all criteria are the same, negatively impact sort by goals_against (lower is better)
    result = a[:goals_against] <=> b[:goals_against] if result == 0
  
    result
  end

  sorted_goalies
end