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

  Router = Backbone.Router.extend({
    'uploader': 'uploader',

    initialize: (vent) ->
      this.vent = vent

    uploader: ->
      this.vent.emit('upload-route')
  })

  Uploader = Backbone.View.extend({
    el: $('#uploader'),
    events: {
      'click input': 'click_uploader',
      'change input': 'upload'
    }

    initialize: (vent)->
      vent.on('upload-route', _.bind(this.upload_route, this))

    upload: (e)->
      reader = new FileReader()
      reader.onload = () -> 
        $('img').attr('src', reader.result);

        # Get a temporary upload key for s3
        # Store to s3
        # Display upload indicator

      reader.readAsDataURL(e.target.files[0])

    upload_route: () ->

  })
  
  vent = _.extend({}, Backbone.Events);
  router = new Router(vent)
  test = new Uploader(vent)

  Backbone.history.start({pushState: true})

)