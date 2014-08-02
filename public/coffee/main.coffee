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

require(["jquery", "underscore", "backbone"], ($, _, Backbone) ->
  toggle = false

  setInterval () => 
    if toggle
      $('#flasher').text('GGIIFFGGYY')
    else
      $('#flasher').text('GIFGY')
    toggle = !toggle
  , 200

  Uploader = Backbone.View.extend({
    el: $('#uploader'),
    events: {
      'click button': 'click_uploader'
    }

    initialize: ->

    click_uploader: ->
      
  })

  test = new Uploader()
)