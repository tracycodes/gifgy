define ["jquery", "underscore", "backbone"], ($, _, Backbone) ->
  return Backbone.View.extend({
    el: '#dropzone',

    events: {
      'keypress' : 'keypressed',
      'mouseenter': 'mouse_over',
    }

    initialize: (vent)->
      this.$el.attr('tab-index', -1).removeClass('hidden')
      $(document).keyup((e) => @keypressed(e))

    upload: (e)->
      reader = new FileReader()
      reader.onload = () -> 
        $('img').attr('src', reader.result);

        # Get a temporary upload key for s3
        # Store to s3
        # Display upload indicator

      reader.readAsDataURL(e.target.files[0])
    
    mouse_over: ->
      this.$el.focus()

    keypressed: (e) ->
      keycode = e.keyCode || e.which
      if keycode == 27
        this.$el.addClass('hidden')

  })
