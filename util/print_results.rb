def print_results sorted_players
  names = []

  sorted_players.each_with_index do |player, idx|
    names << " ##{idx + 1} - #{player[:name]} - #{player[:team]}"
  end

  puts names
end