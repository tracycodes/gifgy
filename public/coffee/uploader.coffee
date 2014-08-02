require ["backbone" ,"jquery", "underscore"], (Backbone, $, _) ->
  return BackBone.View.Extend({
    events: {
      'click #uploader': 'click_uploader'
    }

    initialize: ->

    click_uploader: ->
      alert('yeah')
  })

