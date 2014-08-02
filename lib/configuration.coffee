yaml = require('js-yaml')
fs   = require('fs')

config = yaml.safeLoad fs.readFileSync('./configuration.yml', 'utf8')

module.exports = ( key ) ->
  config[key]
