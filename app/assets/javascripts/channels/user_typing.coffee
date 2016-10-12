App.user_typing = App.cable.subscriptions.create "UserTypingChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    @listen()

  disconnected: ->
    # Called when the subscription has been terminated by the server
    @stop_listening()

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log(data)

  user_is_typing: (typing) ->
    @perform 'user_is_typing', {typing: typing, chatroom_id: $('body').data('current-chatroom')}

  listen: ->
    chatroom_id = $('body').data('current-chatroom')
    @perform 'listen', {chatroom_id: chatroom_id}
    console.log('connected to UserTypingChannel:' + chatroom_id)

  stop_listening: ->
    @perform 'stop_listening'
    console.log('disconnecting from all UserTypingChannels')
