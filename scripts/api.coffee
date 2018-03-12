cryptojs = require('crypto-js')

module.exports = (robot) ->

#   robot.hear /badger/i, (res) ->
#     res.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"
  robot.respond /api ([^\s]*) ([^\s]*)/i, (res) ->
    query = res.match[1]
    key = res.match[2]
    #CryptoJS is being used in javascript to generate the hash security keys
    # We need to pass the url parameters as well as the key to return a SHA256
    hash = cryptojs.HmacSHA256(query, key)
    # That hash generated has to be set into base64
    hash64 = cryptojs.enc.Base64.stringify(hash)
    res.reply hash64



  robot.respond /open the (.*) doors/i, (res) ->
    doorType = res.match[1]
    if doorType is "pod bay"
      res.reply "I'm afraid I can't let you do that."
    else
      res.reply "Opening #{doorType} doors"
  
  robot.hear /I like pie/i, (res) ->
    res.emote "makes a freshly baked pie"
  
  lulz = ['lol', 'rofl', 'lmao']
  
  robot.respond /lulz/i, (res) ->
    res.send res.random lulz
  
  robot.topic (res) ->
    res.send "#{res.message.text}? That's a Paddlin'"
  
  
  enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
  leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  
  robot.enter (res) ->
    res.send res.random enterReplies
  robot.leave (res) ->
    res.send res.random leaveReplies

  
  
  robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
    room   = req.params.room
    data   = JSON.parse req.body.payload
    secret = data.secret
  
    robot.messageRoom room, "I have a secret: #{secret}"
  
    res.send 'OK'
  
  robot.error (err, res) ->
    robot.logger.error "DOES NOT COMPUTE"
  
    if res?
      res.reply "DOES NOT COMPUTE"
  
#   robot.respond /have a soda/i, (res) ->
#     # Get number of sodas had (coerced to a number).
#     sodasHad = robot.brain.get('totalSodas') * 1 or 0
  
#     if sodasHad > 4
#       res.reply "I'm too fizzy.."
  
#     else
#       res.reply 'Sure!'
  
#       robot.brain.set 'totalSodas', sodasHad+1
  
#   robot.respond /sleep it off/i, (res) ->
#     robot.brain.set 'totalSodas', 0
#     res.reply 'zzzzz'
