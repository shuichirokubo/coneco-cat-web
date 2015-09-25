cronJob      = require('cron').CronJob
random       = require('hubot').Response::random
request_json = require('request-json')
request      = require('request')
fs           = require('fs')
http         = require('http')
url          = require('url')
Twitter      = require('twitter')

rakuten_client = request_json.createClient(
  'https://app.rakuten.co.jp/services/api/IchibaItem/Search/20140222?format=json&keyword=%E7%8C%AB%20%E3%83%9E%E3%82%B9%E3%82%B3%E3%83%83%E3%83%88&affiliateId=0e2a74f8.b705f347.0e2a74f9.ce1173da&applicationId=bfc5bca21a7bac85a197a29ebeab80dd&sort=-affiliateRate'
)
upload_url = 'https://upload.twitter.com/1.1/media/upload.json'
values = [0..19]

module.exports = (robot) ->

  keys = {
    consumer_key: process.env.HUBOT_TWITTER_KEY
    consumer_secret: process.env.HUBOT_TWITTER_SECRET
    access_token: process.env.HUBOT_TWITTER_TOKEN
    access_token_secret: process.env.HUBOT_TWITTER_TOKEN_SECRET
  }
  @client = new Twitter(keys)

  do_tweet = ->
    value = random values
    rakuten_client.get('', (err, res, body) ->
      item_price = "お買い得！ " + body.Items[value].Item.itemPrice + "円"
      catch_copy = body.Items[value].Item.catchcopy.substring(0, 30)
      afl_url    = body.Items[value].Item.affiliateUrl
      image_url  = body.Items[value].Item.mediumImageUrls[0].imageUrl
      tweet = """
        #{item_price}
        #{catch_copy}
        #{afl_url}
      """
      robot.send {}, tweet
      console.log(value)
    )

  cronjob = new cronJob(
    cronTime: "0 5,25,45 * * * *"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      do_tweet()
  )

  cronjob.start()
