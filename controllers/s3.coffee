direct_upload = require('../lib/direct_upload')

module.exports = ( app ) ->

  app.get '/s3/creds', ( req, res ) ->

    direct_upload ( info ) ->
      res.status( 201 ).send( info )

