# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class UserTypingChannel < ApplicationCable::Channel
  def subscribed
  end

  def unsubscribed
    stop_all_streams
  end

  def listen data
    stop_all_streams
    stream_from "user_typing:#{data['chatroom_id']}"
  end

  def stop_listening
    stop_all_streams
  end

  def user_is_typing(data)
    UserTypingRelayJob.perform_later(data['typing'], data['chatroom_id'], current_user)
  end
end
