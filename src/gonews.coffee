# Description
#   Hubot golang news pulled from reddit
#
# Configuration:
#   GONEWS_RSS_FEED_URL
#
# Commands:
#   gonews latest [\d+] - returns list of latest golang news. Default 5 items per response...
#
# Notes:
#   GONEWS_RSS_FEED_URL is not needed. It will fall back to reddit/r/golang
#
# Author:
#   Nevio Vesic (0x19) <nevio.vesic@gmail.com>

parser = require 'parse-rss'

reddit_url = process.env.GONEWS_RSS_FEED_URL || "https://www.reddit.com/r/golang/.rss"

module.exports = (robot) ->

  robot.respond /gonews help/i, (msg) ->
    cmds = robot.helpCommands()
    cmds = (cmd for cmd in cmds when cmd.match(/(gonews)/))
    msg.send cmds.join("\n")

  robot.respond /gonews latest ?(\d+)?/i, (msg) ->
    random = Math.floor(Math.random() * (2000000 - 1000000) + 1000000)
    count  = msg.match[1] || 5

    robot.logger.info "Fetching latest #{count} rss feed messages"
    robot.logger.info "#{reddit_url}?time=#{random}"

    parser "#{reddit_url}?time=#{random}", (err,rss)->
      if err
        msg.send "Error happen while fetching golang news: #{err}"
        return

      for feed in rss[0..count]
        robot.emit 'slack.attachment',
          message: msg.message
          content:
            title: feed.title,
            title_link: feed.link
            text: feed.description
