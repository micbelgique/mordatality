Rails.application.routes.draw do
  root :to => 'home#show'

  namespace :api do
    namespace :twilio do
      resources :messages
    end
  end
end
