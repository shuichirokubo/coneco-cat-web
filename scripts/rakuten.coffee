cronJob      = require('cron').CronJob
random       = require('hubot').Response::random
request_json = require('request-json')
request      = require('request')
fs           = require('fs')
http         = require('http')
url          = require('url')
twit         = require('twit')
async        = require('async')

# for rakuten webservice
rakutenUrl      = 'https://app.rakuten.co.jp/services/api/IchibaItem/Search/20140222?format=json&affiliateId=0e2a74f8.b705f347.0e2a74f9.ce1173da&applicationId=bfc5bca21a7bac85a197a29ebeab80dd&sort=-affiliateRate'
searchWordArray = ["猫 ぬいぐるみ"]

module.exports = (robot) ->

  keysForImage = {
    consumer_key:        process.env.HUBOT_TWITTER_KEY
    consumer_secret:     process.env.HUBOT_TWITTER_SECRET
    access_token:        process.env.HUBOT_TWITTER_TOKEN
    access_token_secret: process.env.HUBOT_TWITTER_TOKEN_SECRET
  }
  @clientForImage = new twit(keysForImage)

  do_tweet = ->
    async.series({
      search: (callback) ->
        console.log('search')
        searchWord     = random searchWordArray
        rakutenUrl     += '&keyword=' + encodeURIComponent(searchWord)
        rakuten_client = request_json.createClient(rakutenUrl)
        value          = random [0..19]
        rakuten_client.get('', (err, res, body) ->
          item_price = "お買い得！" + body.Items[value].Item.itemPrice + "円"
          catch_copy = body.Items[value].Item.catchcopy.substring(0, 30)
          afl_url    = body.Items[value].Item.affiliateUrl
          image_url  = body.Items[value].Item.mediumImageUrls[0].imageUrl
          request.get(image_url)
            .on('response', (res) ->
            ).pipe(fs.createWriteStream('./rakuten_images/saved.jpg'))
          tweet = """
            【#{searchWord}グッズ】
            #{item_price}
            #{catch_copy}
            #{afl_url}
          """
          callback(null, tweet)
        )
      post: (callback) ->
        console.log('post')
        setTimeout(
          () ->
            callback(null, 'post')
          , 5000
        )
    }, (err, result) ->
      b64img = fs.readFileSync('./rakuten_images/saved.jpg', { encoding: 'base64' })
      @clientForImage.post('media/upload', { media_data: b64img }, (err, data, res) ->
        mediaIdStr = data.media_id_string
        params = { status: result.search, media_ids: [mediaIdStr] }
        @clientForImage.post('statuses/update', params, (e, d, r) ->
        )
      )
    )

  cronjob = new cronJob(
    cronTime: "0 */15 * * * *"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      do_tweet()
  )

  cronjob.start()
