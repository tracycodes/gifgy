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

require([
  "jquery", 
  "underscore", 
  "backbone", 
  "landing", 
  "uploader", 
  "router"
], ($, _, Backbone, Landing, Uploader, Router) ->
  
  vent = _.extend({}, Backbone.Events);
  router = new Router(vent)
  uploader = new Uploader(vent)
  landing = new Landing(vent)

  Backbone.history.start({pushState: true})
)