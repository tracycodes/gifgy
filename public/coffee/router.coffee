define ["jquery", "underscore", "backbone"], ($, _, Backbone) ->
  return Backbone.Router.extend({
    'uploader': 'uploader',

    initialize: (vent) ->
      this.vent = vent

    uploader: ->
      this.vent.emit('upload-route')
  })
  