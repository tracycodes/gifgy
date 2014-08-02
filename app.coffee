express = require('express')
app = express()
app.use require('body-parser').urlencoded( extended: true )

#####################
##   Controllers   ##
#####################
require( './controllers/gifs' )( app )
#####################

app.listen( 3000 )
console.log( 'Listening on port 3000' )
