require_relative './get_games_by_date'

def get_user_input
  puts "Do you want to filter for only players that are available for today?"
  puts "(This eliminate any players currently on waivers)"
  puts "Type y or n and hit enter"
  
  today_filter_user_input = gets.chomp

  loop do
    if today_filter_user_input == 'y' || today_filter_user_input == 'n'
      break
    else
      puts 'Invalid entry. Type "y" or "n"'
      today_filter_user_input = gets.chomp
    end
  end

  today_filter_user_input == 'y' ? get_games_by_date() : ''
end
