require.config({
  paths: {
    "jquery": "../components/jquery/dist/jquery",
    "underscore": "../components/underscore/underscore",
    "backbone": "../components/backbone/backbone",
  },
  shim: {
    'backbone': {
      deps: ['underscore', 'jquery'],
      exports: 'Backbone'
    },
    'underscore': {
      exports: '_'
    }
  }
})

require(["jquery", "underscore", "uploader"], ($, _, Uploader) ->
  toggle = false

  setInterval () => 
    if toggle
      $('#flasher').text('GGIIFFGGYY')
    else
      $('#flasher').text('GIFGY')
    toggle = !toggle
  , 200

  uploader = new Uploader()
)