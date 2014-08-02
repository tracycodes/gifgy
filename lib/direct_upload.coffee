crypto = require('crypto')
config = require('../lib/configuration')

module.exports = ( callback ) ->

  _date = new Date()
  s3Policy =
    expiration: '' + (_date.getFullYear()) + '-' + (_date.getMonth() + 1) + '-' + (_date.getDate()) + 'T' + (_date.getHours() + 1) + ':' + (_date.getMinutes()) + ':' + (_date.getSeconds()) + 'Z'
    conditions: [
      { bucket: config('AWS_GIFS_BUCKET') }
      [ 'starts-with', '$Content-Disposition', '' ]
      [ 'starts-with', '$key', 'someFilePrefix_' ]
      { acl: 'public-read' }
      { success_action_redirect: 'http://gif.gy/gifs/doneskis' }
      [ 'content-length-range', 0, 8388608 ] # 8 megs
      [ 'eq', '$Content-Type', 'image/gif' ]
    ]

  callback
    s3PolicyBase64: new Buffer(JSON.stringify(s3Policy)).toString('base64')
    s3Signature: crypto.createHmac('sha1', config('AWS_SECRET_KEY') ).update(s3Policy).digest('base64')
    s3Key: config('AWS_ACCESS_KEY')
    s3Redirect: 'http://gif.gy/gifs/okaysauce'
    s3Policy: s3Policy
