require_relative './get_games_by_date'
require_relative './swap_quotes'

def get_user_input
  puts "What position do you want to target?"
  puts "0: Center"
  puts "1: Left Wing"
  puts "2: Right Wing"
  puts "3: All Forwards (C, LW, RW)"
  puts "4: Defenseman"
  puts "5: Goaltenders"
  puts "6: All Skaters (F or D)"

  position_filter = gets.chomp

  loop do
    if position_filter.to_i >= 0 && position_filter.to_i < 7
      break
    else
      puts 'Invalid entry. Type "0-6" to choose a targeted position'
      position_filter = gets.chomp
    end
  end


  puts "Do you want to filter for only players that are available for today?"
  puts "(This eliminates any players currently on waivers)"
  puts "y: Yes. Only players with games today (no waivers)"
  puts "n: No. Search all available players"
  
  today_filter_user_input = gets.chomp

  loop do
    if today_filter_user_input == 'y' || today_filter_user_input == 'n'
      break
    else
      puts 'Invalid entry. Type "y" or "n"'
      today_filter_user_input = gets.chomp
    end
  end

  todays_games_filter = today_filter_user_input == 'y' ? get_games_by_date() : ''
  waivers_filter = case today_filter_user_input
  when 'y'
    "['FREEAGENT']"
  when 'n'
    "['FREEAGENT','WAIVERS']"
  end


  filter = "{'players':{'filterStatus':{'value':#{waivers_filter}},'filterSlotIds':{'value': [#{position_filter}]},#{todays_games_filter}'filterRanksForScoringPeriodIds':{'value':[17]},'sortPercChanged':{'sortPriority':1,'sortAsc':false}, 'sortPercOwned':{'sortPriority':2,'sortAsc':false}, 'limit': 150,'filterStatsForTopScoringPeriodIds':{'value':10,'additionalValue':['002024','102024','002023','012024','022024','032024','042024']}}}"
  swap_quotes(filter)
end


