def swap_quotes(str)
  str = str.gsub(/'/, '##TEMP##')
  str = str.gsub(/"/, "'")
  str = str.gsub('##TEMP##', '"')
  
  return str
end
