# Description:
#   Tell where is every one
#
# Commands:
#   hubot where is <people> - Show where is mentioned people
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md


module.exports = (robot) ->

  robot.router.post '/api/v1/locations/', (req, res) ->
    ip = req.connection.remoteAddress
    data = {
      ip: ip,
      place: req.body.place || ""
    }

    peoples = JSON.parse(robot.brain.get('peoples'))

    unless peoples?
      peoples = {}

    person = req.body.person
    peoples[person] = data

    robot.brain.set('peoples', JSON.stringify(peoples))
    res.send 'OK'

  robot.respond /where is (.+)/i, (msg) ->
    peoples = JSON.parse(robot.brain.get('peoples'))
    person = msg.match[1]

    if peoples?
      data = peoples[person]

      if data?
        msg.reply("I found " + person + " in " + data.place + " [" + data.ip + "]")
        return

    else
      msg.reply("How should I know ?")
      msg.reply("I didn't get any info about that dude")
