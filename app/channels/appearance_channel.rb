# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    current_user.appear
    AppearanceRelayJob.perform_later(current_user)
    stream_from 'appearances'
  end

  def unsubscribed
    current_user.disappear
    AppearanceRelayJob.perform_later(current_user)
    stop_all_streams
  end

  def appear(data)
    current_user.appear on: data['appearing_on']
  end

  def away
    current_user.away
  end
end
