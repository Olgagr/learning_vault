Rails.application.routes.draw do
  resource :session
  resource :users, only: %i[ new create ]
  resources :passwords, param: :token
  resources :categories
  resources :resources
  get "dashboard" => "dashboard#index"

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  root "dashboard#index"
end
