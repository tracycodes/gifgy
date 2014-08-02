require ["jquery", "underscore", "backbone"], ($, _, Backbone) ->
  debugger;
  return Backbone.View.extend({
    id: '#uploader',
    events: {
      'click': 'click_uploader'
    }

    initialize: ->
      alert('yup')

    click_uploader: ->
      alert('yeah')
  })

