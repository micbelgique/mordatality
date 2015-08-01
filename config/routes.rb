Rails.application.routes.draw do
  root :to => 'home#show'

  resources :estimations

  resource :simulation

  namespace :api do
    namespace :twilio do
      resources :messages
    end

    namespace :simulation do
      resources :probabilities
    end
  end
end
