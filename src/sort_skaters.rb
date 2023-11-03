def sort_skaters all_skaters
  # filtered_skaters = all_skaters.select{ |skater| skater[:games_played] > 0 }
  # byebug
  sorted_skaters = all_skaters.sort do |a, b|

    # Sort by games_with_points/games_played ratio (higher is better)
    ratio_a = (a[:games_played] != 0) ? (a[:games_with_points].to_f / a[:games_played]) : 0
    ratio_b = (b[:games_played] != 0) ? (b[:games_with_points].to_f / b[:games_played]) : 0
    result = ratio_b <=> ratio_a  # Reverse order for higher priority

    # result = -1 if b[:games_played] == 0

    # If games_with_points ratio is the same, sort by goals (higher is better)
    result = b[:goals] <=> a[:goals] if result == 0
  
    # If goals are also the same, sort by assists (higher is better)
    result = b[:assists] <=> a[:assists] if result == 0
  
    # If still the same, sort by who played more games to even out averages (higher is better)
    result = b[:games_played] <=> a[:games_played] if result == 0

    # If assists are also the same, sort by average_ppg (higher is better)
    result = b[:average_ppg] <=> a[:average_ppg] if result == 0

    # After averages, sort by points scored with Goals/Assists (higher is better)
    result = b[:category_point_games] <=> a[:category_point_games] if result == 0
  
    # If all criteria are the same, negatively impact sort by bad_games (lower is better)
    result = a[:bad_games] <=> b[:bad_games] if result == 0
  
    result
  end
  
  sorted_skaters
end
