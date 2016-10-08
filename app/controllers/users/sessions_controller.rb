class Users::SessionsController < Devise::SessionsController

  protected

    before_action :broadcast_disappearance, only: :destroy
    after_action :broadcast_appearance, only: :create

  private

    def broadcast_disappearance
      AppearanceRelayJob.perform_later(current_user)
    end

    def broadcast_appearance
      AppearanceRelayJob.perform_later(current_user)
    end

end
