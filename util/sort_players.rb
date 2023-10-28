def sort_players all_players
  sorted_players = all_players.sort do |a, b|

    # Sort by games_with_points/games_played ratio (higher is better)
    ratio_a = (a[:games_played] != 0) ? (a[:games_with_points].to_f / a[:games_played]) : 0
    ratio_b = (b[:games_played] != 0) ? (b[:games_with_points].to_f / b[:games_played]) : 0
    result = ratio_b <=> ratio_a  # Reverse order for higher priority

    result = 0 if b[:games_played] == 0

    # If games_with_points ratio is the same, sort by goals (higher is better)
    result = b[:goals] <=> a[:goals] if result.zero?
  
    # If goals are also the same, sort by assists (higher is better)
    result = b[:assists] <=> a[:assists] if result.zero?
  
    # If assists are also the same, sort by average_ppg (higher is better)
    result = b[:average_ppg] <=> a[:average_ppg] if result.zero?
  
    # If all criteria are the same, negatively impact sort by bad_games (lower is better)
    result = a[:bad_games] <=> b[:bad_games] if result.zero?
  
    result
  end

  sorted_players
end


# Example of each player object coming in
{
  :name=>"Seth Jarvis", 
  # :team=>"Carolina Hurricanes"  ** This is an eventual attribute that is not yet incorporated **
  :games_played => 6, 
  :games_with_points => 3,
  :goals => 4.0, 
  :assists => 2.0, 
  :total_points => 35.300000000000004, 
  :average_ppg => 5.883333333333334, 
  :multi_point_nights => 1, 
  :category_point_games => 1, 
  :bad_games => 2
}

# *** What is being held most valuable? ***
# Out of how many games played, how many games_with_points ? => Send to front
# if tied, tie breaker is goals and then assists
# if still tied, average_ppg gets sent to front



# Out of how many games played, how many are "bad" ?

