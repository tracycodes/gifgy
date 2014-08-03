guid = require('guid')
config = require('../lib/configuration')

redis = require('redis').createClient()

module.exports = ( app ) ->

  app.get '/api/keywords/search/:query', ( req, res ) ->

    redis.select config('REDIS_TAGS_DB'), ->

      search = req.params.query + '*'
      redis.keys search, ( err, keywords ) ->
        throw err if err

        res.json( keywords ).end()

  ################
  ##   Helper   ##
  ################
  redirectToGif = ( gif_id, res ) ->
    redis.select config('REDIS_METADATA_DB'), ->
      redis.hget 'gifs', gif_id, ( err, gif_url ) ->
        if gif_url
          res.redirect( 301, gif_url )
        else
          res.status( 303, config('DEFAULT_GIF_URL') )
  ################

  app.get '/', ( req, res ) ->

    parts = req.headers.host.split(/\./)
    if parts.length == 3
      redis.select config('REDIS_TAGS_DB'), ->
        keyword = parts[0]
        redis.zrevrange keyword, -0, -0, ( err, gif_id ) ->
          if gif_id
            redirectToGif( gif_id, res )
          else
            res.redirect( 301, c('DEFAULT_GIF_URL') )
    else
      res.render 'public', ( err, html ) ->
        res.send( html )

  app.get '/g/:id', ( req, res ) ->
    redirectToGif( req.params.id, res )

  #######################################
  ##   Get Random keys with two gifs   ##
  #######################################
  getRandomKeywordWithTwoGifs = ( redis, callback ) ->
    redis.randomkey ( err, keyword ) ->
      throw err if err

      redis.select config('REDIS_TAGS_DB'), ( err ) ->
        throw err if err

        redis.zcard keyword, ( err, count ) ->
          throw err if err

          if count < 2
            return getRandomKeywordWithTwoGifs( redis, callback )
         
          one_index = Math.round( Math.random()*count )
          two_index = one_index
          while one_index == two_index
            two_index = Math.round( Math.random()*count )

          redis.zrange keyword, one_index, one_index, ( err, one_gif_id ) ->
            throw err if err

              redis.zrange keyword, two_index, two_index, ( err, two_gif_id ) ->
                throw err if err

                gif_ids = [ one_gif_id, two_gif_id ]
                callback( keyword, gif_ids )
      
  #######################################

  app.get '/api/gifs/random', ( req, res ) ->

    redis.select config('REDIS_TAGS_DB'), ( err ) ->
      throw err if err

      getRandomKeywordWithTwoGifs redis, ( keyword, gif_ids ) ->
       
        redis.select config('REDIS_METADATA_DB'), ( err ) ->
          throw err if err

          resp =
            keyword: keyword
            gifs: []

          for gif_id in gif_ids
            redis.hget 'gifs', gif_id, ( err, gif_url ) ->
              throw err if err

              resp.gifs.push
                id: gif_id
                url: gif_url

              if resp.length == gif_ids.length
                res.json( resp ).end()
  
  ##########################
  ##   Upload a new GIF   ##
  ##########################
  app.post '/api/gifs', ( req, res ) ->
 
    tags = req.body.tags || []
    if tags.length == 0
      return res.status( 400 ).end()

    gif_id = guid.raw()
    gif_url = 'http://i.imgur.com/t8IHP.gif'

    res.status( 201 ).end()

    redis.select config('REDIS_METADATA_DB'), ->
      redis.hset( 'gifs', gif_id, gif_url )

      redis.select config('REDIS_TAGS_DB'), ->
        now = (new Date()).getTime()/1000
        for tag in tags
          redis.zadd( tag, now, gif_id )
  ##########################

