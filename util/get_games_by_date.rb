# External Dependencies
require 'uri'
require 'http'
require 'byebug'

def get_games_by_date
  today = Time.new
  date = "#{today.year}#{today.month}#{today.day}"
  
  uri = "https://site.api.espn.com/apis/fantasy/v2/games/fhl/games?useMap=true&dates=#{date}&pbpOnly=true"
  
  res = HTTP.get(uri)
  games_by_date = res.parse['events']
  
  ids_of_teams_with_games = []
  games_by_date.each do |game|
    game['competitors'].each do |team|
      ids_of_teams_with_games << team['id'].to_i
    end
  end

  "'filterProTeamIds':{'value':#{ids_of_teams_with_games}},"
end



# Example of response
# {
#   "statistics":{},
#   "events":[
#     {
#       "id":"401559374",
#       "competitionId":"401559374",
#       "uid":"s:70~l:90~e:401559374~c:401559374",
#       "date":"2023-11-01T00:00:00Z",
#       "timeValid":true,
#       "period":0,
#       "clock":"0:00",
#       "links":[
#         {
#           "language":"en-US",
#           "rel":["summary","desktop","event"],
#           "href":"https://www.espn.com/nhl/game/_/gameId/401559374",
#           "text":"Gamecast",
#           "shortText":"Gamecast",
#           "isExternal":false,
#           "isPremium":false
#         }
#       ],
#       "status":"pre",
#       "summary":"10/31 - 8:00 PM EDT",
#       "lastPlay":{},
#       "recentPlays":[],
#       "percentComplete":0,
#       "scoringPlays":[],
#       "fullStatus":{
#         "clock":0.0,
#         "displayClock":"0:00",
#         "period":0,
#         "type":{
#           "id":"1",
#           "name":"STATUS_SCHEDULED",
#           "state":"pre",
#           "completed":false,
#           "description":"Scheduled",
#           "detail":"Tue, October 31st at 8:00 PM EDT",
#           "shortDetail":"10/31 - 8:00 PM EDT"
#         }
#       },
#       "link":"https://www.espn.com/nhl/game/_/gameId/401559374",
#       "broadcasts":[
#         {
#           "type":"TV",
#           "lang":"en",
#           "region":"us",
#           "typeId":1,
#           "isNational":true,
#           "shortName":"ESPN"
#         }
#       ],
#       "broadcast":"ESPN",
#       "fantasySource":{
#         "id":"0",
#         "description":"none",
#         "state":"none"
#       },
#       "competitors":[
#         {
#           "id":"21",
#           "type":"team",
#           "homeAway":"home",
#           "abbreviation":"TOR",
#           "score":"",
#           "winner":false,
#           "record":"5-2-1, 11 PTS",
#           "name":"Maple Leafs",
#           "lineup":[],
#           "probables":[
#             {
#               "name":"probableStartingGoalie",
#               "playerId":4271575,
#               "status":{
#                 "type":"confirmed"
#               }
#             }
#           ]
#         },
#         {
#           "id":"8",
#           "type":"team",
#           "homeAway":"away",
#           "abbreviation":"LA",
#           "score":"",
#           "winner":false,
#           "record":"4-2-2, 10 PTS",
#           "name":"Kings",
#           "lineup":[],
#           "probables":[
#             {
#               "name":"probableStartingGoalie",
#               "playerId":5734,
#               "status":{
#                 "type":"expected"
#               }
#             }
#           ]
#         }
#       ]
#     },
#     *** Next Event ***
#     {"id":"401559373","competitionId":"401559373","uid":"s:70~l:90~e:401559373~c:401559373","date":"2023-11-01T02:00:00Z","timeValid":true,"period":0,"clock":"0:00","links":[{"language":"en-US","rel":["summary","desktop","event"],"href":"https://www.espn.com/nhl/game/_/gameId/401559373","text":"Gamecast","shortText":"Gamecast","isExternal":false,"isPremium":false}],"status":"pre","summary":"10/31 - 10:00 PM EDT","lastPlay":{},"recentPlays":[],"percentComplete":0,"scoringPlays":[],"fullStatus":{"clock":0.0,"displayClock":"0:00","period":0,"type":{"id":"1","name":"STATUS_SCHEDULED","state":"pre","completed":false,"description":"Scheduled","detail":"Tue, October 31st at 10:00 PM EDT","shortDetail":"10/31 - 10:00 PM EDT"}},"link":"https://www.espn.com/nhl/game/_/gameId/401559373","broadcasts":[{"type":"Web","lang":"en","region":"us","typeId":4,"isNational":true,"shortName":"NHLPP|ESPN+"}],"broadcast":"NHLPP|ESPN+","fantasySource":{"id":"0","description":"none","state":"none"},"competitors":[{"id":"22","type":"team","homeAway":"home","abbreviation":"VAN","score":"","winner":false,"record":"5-2-1, 11 PTS","name":"Canucks","lineup":[],"probables":[{"name":"probableStartingGoalie","playerId":3096217,"status":{"type":"expected"}}]},{"id":"27","type":"team","homeAway":"away","abbreviation":"NSH","score":"","winner":false,"record":"4-4-0, 8 PTS","name":"Predators","lineup":[],"probables":[{"name":"probableStartingGoalie","playerId":3042109,"status":{"type":"expected"}}]}]}]}

