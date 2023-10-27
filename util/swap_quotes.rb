def swap_quotes(str)
  str = str.gsub(/'/, '##TEMP##')
  str = str.gsub(/"/, "'")
  str = str.gsub('##TEMP##', '"')
  
  return str
end


# str = "Hi 'Andrew'. Whats 'up?'"

# puts swap_quotes(str)