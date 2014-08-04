define ["jquery", "backbone"], ($, Backbone) ->
  return Backbone.View.extend({
    el: '.faceoff-gif'
    events: {
      'click .faceoff-gif-image': 'click_image'
    },

    click_image: ->
      selection = $(this).parent()
      selection.addClass('is-selected')
      $('.faceoff-gif').not(selection).addClass('is-not-selected')
      $(this).addClass('upvote')
  })

