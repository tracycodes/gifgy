define ["jquery", "underscore", "backbone"], ($, _, Backbone) ->
  return Backbone.View.extend({
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
    
    upload_route: ->
      alert('yeah')
  })
