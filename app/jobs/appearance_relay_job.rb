class AppearanceRelayJob < ApplicationJob
  queue_as :default



  def perform(user)
    ActionCable.server.broadcast 'appearances',
                                 {
                                     appearance: ApplicationController.helpers.link_appearance(user),
                                     username: user.username
                                 }
  end
end
