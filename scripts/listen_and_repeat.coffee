# Description:
#   Listen to a post request and repeat the content in channel
#

module.exports = (robot) ->

  robot.on "listen_and_repeat", (string) ->
    robot.send {}, "[ " + string.ip + " ]: " + string.msg

  robot.router.post '/api/v1/repeat/', (req, res) ->
    ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
    robot.emit "listen_and_repeat", {
      msg: req.body.msg,
      ip: ip,
    }
    res.send 'OK'
