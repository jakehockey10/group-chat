App.appearance = App.cable.subscriptions.create "AppearanceChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log("connected to AppearanceChannel")

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log("disconnected from AppearanceChannel")

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $("li##{data.username} > a[data-behavior='chatroom-link']").html(data.appearance)

  appear: ->
    @perform 'appear'

  away: ->
    @perform 'away'

$(document).on 'page:change', ->
  App.appearance.appear()

$(document).on 'click', '[data-behavior~=appear_away]', ->
  App.appearance.away()
  false