cronJob = require('cron').CronJob
random  = require('hubot').Response::random
twit    = require('twit')

module.exports = (robot) ->

  keys = {
    consumer_key: process.env.HUBOT_TWITTER_KEY
    consumer_secret: process.env.HUBOT_TWITTER_SECRET
    access_token: process.env.HUBOT_TWITTER_TOKEN
    access_token_secret: process.env.HUBOT_TWITTER_TOKEN_SECRET
  }
  @client = new twit(keys)

  do_tweet = ->
    @client.get('search/tweets', { q: '猫', count: 1 }, (err, data, response) ->
      data.statuses.forEach (tweet) ->
        @client.post('statuses/retweet/:id', { id: tweet.id_str }, (err, data, response) ->
          console.log(err)
        )
    )

  cronjob = new cronJob(
    cronTime: "0 15,30,45 * * * *"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      do_tweet()
  )

  cronjob.start()
