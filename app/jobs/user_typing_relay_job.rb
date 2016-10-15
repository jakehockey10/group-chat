class UserTypingRelayJob < ApplicationJob
  queue_as :default

  def perform(typing, chatroom_id, user)
    ActionCable.server.broadcast "user_typing:#{chatroom_id}",
                                 {
                                     typing: typing,
                                     chatroom_id: chatroom_id,
                                     username: user.username,
                                     user_id: user.id
                                 }
  end
end
