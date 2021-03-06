# Description:
#   Listen to a post request and repeat the content in channel
#

module.exports = (robot) ->

  robot.router.post '/api/v1/repeat/', (req, res) ->
    ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
    robot.send({ room: 'yellowen-general' }, ["[ " + ip + " ]: " + req.body.msg])

    robot.emit "listen_and_repeat", {
      msg: req.body.msg,
      ip: ip,
    }
    res.end 'OK'
