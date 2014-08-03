config = require('../lib/configuration')

redis = require('redis').createClient()

module.exports = ( app ) ->

  app.post '/api/votes', ( req, res ) ->

    tag = req.body.tag
    gif_id = req.body.gif_id

    res.status( 200 ).end()

    redis.select config('REDIS_TAGS_DB'), ->
      redis.zscore tag, gif_id, ( err, score ) ->
        return unless score

        redis.select config('REDIS_METADATA_DB'), ->

          ip_address = req.headers['x-forwarded-for'] || req.connection.remoteAddress
          pair = ip_address + '-' + gif_id

          ##  Has this ip_address already voted on this gif?
          redis.exists pair, ( err, exists ) ->
            throw err if err
            return if exists

            ##  Record this ip_address and tag was already voted
            redis.set( pair, 1 )

            ##  Record that this ip_address has already voted on the gif
            redis.select config('REDIS_METADATA_DB'), ( err ) ->
              ##  Add the vote to the gif in the tag sorted set
              redis.zincrby( tag, config('VOTE_INCREASE'), gif_id )

