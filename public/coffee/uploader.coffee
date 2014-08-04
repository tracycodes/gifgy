define ["jquery", "underscore", "backbone", "dropzone"], ($, _, Backbone, Dropzone) ->
  return Backbone.View.extend({
    el: '#uploader',

    events: {
      'click a': 'click_upload',
    }

    initialize: (vent)->

    click_upload: ->
      dropzone = new Dropzone()
  })
