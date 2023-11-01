def get_todays_date
  today = Time.new
  year= today.year
  month = today.month < 10 ? "0#{today.month}" : today.month
  day = today.day < 10 ? "0#{today.day}" : today.day

  date = "#{year}#{month}#{day}"
end
