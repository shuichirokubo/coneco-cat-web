cronJob      = require('cron').CronJob
random       = require('hubot').Response::random
request_json = require('request-json')
request      = require('request')
fs           = require('fs')
http         = require('http')
url          = require('url')
Twitter      = require('twitter')

# for instagram
instagramUrl = 'https://api.instagram.com/v1/tags/'
tagsArray = ["ねこ","猫","kitty","instacat","ネコ","neko","cat"]

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
    tag              = random tagsArray
    console.log(tag)
    instagramUrl    += encodeURIComponent(tag) + '/media/recent?client_id=9ad0d13ba1bc4af68fd60217ad853471&max_tag_id=980964481902499453'
    console.log(instagramUrl)
    instagram_client = request_json.createClient(instagramUrl)
    value = random [0..19]
    instagram_client.get('', (err, res, body) ->
      request.get(body.data[value].images.low_resolution.url)
        .on('response', (res) ->
        ).pipe(fs.createWriteStream('./saved.jpg'))
      b64img = fs.readFileSync('./saved.jpg', { encoding: 'base64' })
      tweet = """
        #{body.data[value].link}
        by Instagram@#{body.data[value].user.full_name}
        #{body.data[value].caption.text.substring(0, 30)}
      """
      robot.send {}, tweet
    )

  cronjob = new cronJob(
    cronTime: "0 0,10,20,30,40,50 * * * *"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      do_tweet()
  )

  cronjob.start()
