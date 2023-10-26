require 'uri'
require 'http'

uri = URI('https://api.nasa.gov/planetary/apod')
params = {:api_key => "DEMO_KEY"}

res = HTTP.get(uri, :params => params)
puts 'RES BODY: ' + res.body  if res.code == 200

# test
