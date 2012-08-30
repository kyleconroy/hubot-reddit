Robot = require('hubot').robot()
Adapter = require('hubot').adapter()
HTTPS = require 'https'

class Reddit extends Adapter
  send: (user, strings...) ->
    strings.forEach (text) =>
      console.log text

  reply: (user, strings...) ->
    strings.forEach (text) =>
      @bot.reply(user,text)

  run: ->
    self = @
    options =
      username : process.env.HUBOT_REDDIT_USERNAME
      password : process.env.HUBOT_REDDIT_PASSWORD
      subreddit : process.env.HUBOT_REDDIT_SUBREDDIT

    @bot = new KarmaBot(options)

exports.use = (robot) ->
  new Reddit robot

class KarmaBot extends EventEmitter
  self = @
  constructor: (options) ->
    if options.username? and options.password? and options.subreddit?
      @user = options.username
      @pass = options.password
      @subreddit = options.subreddit
    else
      throw new Error("Not enough parameters provided. I need a username, a password, and a subbreddit")

  # Convenience HTTP Methods for posting on behalf of the reddit user
  get: (path, callback) ->
    @request "GET", path, null, callback

  post: (path, body, callback) ->
    @request "POST", path, body, callback

  request: (method, path, body, callback) ->
    console.log "https://#{@domain}#{path}, #{@token}, #{@tokensecret}, null"

    request = @consumer.get "https://#{@domain}#{path}", @token, @tokensecret, null
    console.log request
    request.on "response",(response) ->
      response.on "data", (chunk) ->
        console.log chunk+''
        parseResponse chunk+'',callback

      response.on "end", (data) ->
        console.log 'end request'

      response.on "error", (data) ->
        console.log 'error '+data

    request.end()

    parseResponse = (data,callback) ->
      while ((index = data.indexOf('\r\n')) > -1)
        json = data.slice(0, index)
        data = data.slice(index + 2)
        if json.length > 0
          try
             console.log "json"+json
             callback null, JSON.parse(json)
          catch err
             console.log "error parse"+json
             callback null, data || { }
