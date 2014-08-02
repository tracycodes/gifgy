guid = require('guid')

redis = require('redis').createClient()

module.exports = ( app ) ->

  ################
  ##   Helper   ##
  ################
  redirectToGif = ( gif_id, res ) ->
    redis.hget 'gifs', gif_id, ( err, gif_url ) ->
      if gif_url
        res.redirect( 302, gif_url )
      else
        res.status( 404 ).end()
  ################

  app.get '/', ( req, res ) ->

    keyword = req.headers.host.split(/\./)[0]
    console.log( 'Keyword: ' + keyword )
    redis.zrevrange keyword, -0, -0, ( err, gif_id ) ->
      if gif_id
        redirectToGif( gif_id, res )

  app.get '/g/:id', ( req, res ) ->
    redirectToGif( req.params.id, res )

  app.post '/api/gifs', ( req, res ) ->
 
    tags = req.body.tags || []
    if tags.length == 0
      return res.status( 400 ).end()

    gif_id = guid.raw()
    gif_url = 'http://i.imgur.com/t8IHP.gif'

    redis.hset( 'gifs', gif_id, gif_url )

    now = (new Date()).getTime()/1000
    for tag in tags
      redis.zadd( tag, now, gif_id )

    res.status( 201 ).send( {} )

