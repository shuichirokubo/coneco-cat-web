cronJob      = require('cron').CronJob
random       = require('hubot').Response::random
request_json = require('request-json')
request      = require('request')
fs           = require('fs')
http         = require('http')
url          = require('url')
Twitter      = require('twitter')

# for rakuten webservice
rakutenUrl      = 'https://app.rakuten.co.jp/services/api/IchibaItem/Search/20140222?format=json&affiliateId=0e2a74f8.b705f347.0e2a74f9.ce1173da&applicationId=bfc5bca21a7bac85a197a29ebeab80dd&sort=-affiliateRate'
searchWordArray = ["猫 ぬいぐるみ", "猫 キーホルダー", "猫 かわいい"]

# for twitter
upload_url = 'https://upload.twitter.com/1.1/media/upload.json'

module.exports = (robot) ->

  keys = {
    consumer_key:        process.env.HUBOT_TWITTER_KEY
    consumer_secret:     process.env.HUBOT_TWITTER_SECRET
    access_token_key:    process.env.HUBOT_TWITTER_TOKEN
    access_token_secret: process.env.HUBOT_TWITTER_TOKEN_SECRET
  }
  @client = new Twitter(keys)

  do_tweet = ->
    searchWord     = random searchWordArray
    rakutenUrl     += '&keyword=' + encodeURIComponent(searchWord)
    rakuten_client = request_json.createClient(rakutenUrl)
    value          = random [0..19]
    rakuten_client.get('', (err, res, body) ->
      item_price = "お買い得！ " + body.Items[value].Item.itemPrice + "円"
      catch_copy = body.Items[value].Item.catchcopy.substring(0, 30)
      afl_url    = body.Items[value].Item.affiliateUrl
      image_url  = body.Items[value].Item.mediumImageUrls[0].imageUrl
      tweet = """
        #{searchWord}グッズ
        #{item_price}
        #{catch_copy}
        #{afl_url}
      """
      robot.send {}, tweet
    )

  cronjob = new cronJob(
    cronTime: "0 5,15,25,35,45,55 * * * *"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      do_tweet()
  )

  cronjob.start()
