cronJob      = require('cron').CronJob
random       = require('hubot').Response::random
request_json = require('request-json')
request      = require('request')
fs           = require('fs')
twit         = require('twit')
async        = require('async')

# for instagram
flickerUrl = 'https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=6123d03adcf80439f7f840ff40e2cf5f&extras=owner_name%2Curl_q%2Ctags&format=json&nojsoncallback=1'
textArray = ['ねこ','猫','kitty','ネコ','neko','cat']

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
        text           = random textArray
        flickerUrl    += '&text=' + encodeURIComponent(text)
        flicker_client = request_json.createClient(flickerUrl)
        console.log("search: #{text}")
        console.log("search: #{flickerUrl}")
        flicker_client.get('', (err, res, body) ->
          value = random [0..100-1]
          console.log("value: #{value}")
          request.get(body.photos.photo[value].url_q)
            .on('response', (res) ->
            ).pipe(fs.createWriteStream('./flicker_images/saved.jpg'))
          tweet = """
            #{body.photos.photo[value].title}
            by Flicker@#{body.photos.photo[value].ownername}
            #{body.photos.photo[value].tags.substring(0, 30)}...
          """
          callback(null, tweet)
        )
      post: (callback) ->
        setTimeout(
          () ->
            callback(null, 'post')
          , 5000
        )
    }, (err, result) ->
      b64img = fs.readFileSync('./flicker_images/saved.jpg', { encoding: 'base64' })
      @clientForImage.post('media/upload', { media_data: b64img }, (err, data, res) ->
        mediaIdStr = data.media_id_string
        params = { status: result.search, media_ids: [mediaIdStr] }
        @clientForImage.post('statuses/update', params, (e, d, r) ->
        )
      )
    )

  cronjob = new cronJob(
    cronTime: "0 */20 * * * *"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      do_tweet()
  )

  cronjob.start()
