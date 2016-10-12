#if ($("meta[name='current-user']").length > 0)

createNotification = (title, body) ->
  notification = new Notification(title, {body: body})
  notification.onclick = ->
    window.focus()
    notification.close()
  setTimeout(notification.close.bind(notification), 4000)

App.chatrooms = App.cable.subscriptions.create "ChatroomsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log('connected to ChatroomsChannel')

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log('disconnected to ChatroomsChannel')

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    active_chatroom = $("[data-behavior='messages'][data-chatroom-id='#{data.chatroom_id}']")
    if active_chatroom.length > 0

      if document.hidden
        if $('.strike').length == 0
          active_chatroom.append("<div class='strike'><span>Unread Messages</span></div>")

        if Notification.permission == 'granted'
          createNotification(data.username, data.body)

      else
        App.last_read.update(data.chatroom_id)

      # Insert the message
      active_chatroom.append(data.message)
      active_chatroom.scrollTop(active_chatroom[0].scrollHeight)

    else
      link = $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']")
      link.css("font-weight", "bold")
      if link.has('span.badge').length > 0
        badge = link.find('span.badge')
        val = parseInt(badge.text())
        val++
        badge.text(val)
      else
        link.append('<span class="badge pull-right">1</span>')

  send_message: (chatroom_id, message) ->
    @perform "send_message", {chatroom_id: chatroom_id, body: message}
