Rails.application.routes.draw do
  mount ImageUploader::UploadEndpoint => '/images/upload'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :chatrooms do
    resource :chatroom_users
    resources :messages
  end

  resources :direct_messages

  root to: 'chatrooms#index'
end
