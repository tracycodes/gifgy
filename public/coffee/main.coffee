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
      'click input': 'click_uploader',
      'change input': 'upload'
    }

    initialize: ->

    upload: (e)->
      reader = new FileReader()
      reader.onload = () -> 
        $('img').attr('src', reader.result);
      reader.readAsDataURL(e.target.files[0])

      # Pop the file uploader
      # Retrieve a temporary s3 key
      # Retrieve the image from the element
      # put it at the s3 address
      # Store that address back in our redis db
  })

  test = new Uploader()
)