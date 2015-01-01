# Description:
#   Listen to a post request and repeat the content in channel
#

module.exports = (robot) ->

  robot.router.post '/api/v1/repeat/', (req, res) ->
    ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
    robot.emit "listen_and_repeat", {
      msg: req.body.msg,
      ip: ip,
    }
    robot.send {}, "[ " + ip + " ]: " + req.body.msg
    res.send 'OK'
