express = require('express')
app = express()
app.use require('body-parser').urlencoded( extended: true )

#####################
##   Controllers   ##
#####################
require( './controllers/gifs' )( app )
require( './controllers/s3' )( app )
#####################

app.listen( 3000 )
console.log( 'Listening on port 3000' )