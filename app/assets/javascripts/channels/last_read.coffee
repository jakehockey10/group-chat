#if ($("meta[name='current-user']").length > 0)

App.last_read = App.cable.subscriptions.create "LastReadChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log('Connected to LastReadChannel')

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log('Disconnected from LastReadChannel')

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log(data)

  update: (chatroom_id) ->
    @perform 'update', {chatroom_id: chatroom_id}