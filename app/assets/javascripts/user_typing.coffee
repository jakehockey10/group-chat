$(document).on 'turbolinks:load', ->
  typingTimer = null
  doneTypingInterval = 10
  finalDoneTypingInterval = 500
  is_typing = false

  chatroom_id = $('body').data('current-chatroom')

  $('#message_body').keydown ->
    clearTimeout typingTimer
    if $('#message_body').val
      typingTimer = setTimeout((->
        console.log('typing...')
        App.user_typing.user_is_typing(true, chatroom_id)
        is_typing = true
      ), doneTypingInterval) unless is_typing
  $('#message_body').keyup ->
    clearTimeout typingTimer
    typingTimer = setTimeout((->
      console.log('stopped typing.')
      App.user_typing.user_is_typing(false, chatroom_id)
      is_typing = false
    ), finalDoneTypingInterval) if is_typing