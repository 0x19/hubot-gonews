# Description
#   Hubot golang news extension
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot hello - <what the respond trigger does>
#   orly - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   0x19 <nevio.vesic@gmail.com>

parser = require 'parse-rss'

module.exports = (robot) ->

  robot.respond /gonews/, (res) ->
    url    = "http://golangweekly.com/rss/1b1gb6c4.rss"

    parser url, (err,rss)->
      console.log err if err
      console.log rss

      res.reply rss[0]

  #robot.respond /hello/, (res) ->
  #  res.reply "hello!"
