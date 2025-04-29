# frozen_string_literal: true

Rails.application.routes.draw do
  get '/workshops/pending', to: 'workshops#pending'
  post '/workshop_participants/apply', to: 'workshop_participants#apply'
  # resources :track_workshops
  resources :tracks
  resources :workshop_participants
  resources :participants
  resources :workshop_facilitators
  devise_for :facilitators
  resources :workshops
  resources :application_forms, only: %i[show]
  resources :feedback_forms, only: %i[show edit new]
  resources :questions

  get '/dashboard', to: 'dashboard#show'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', :as => :rails_health_check

  # Defines the root path route ("/")
  root 'workshops#index'

  require 'sidekiq/web'
  unless Rails.env.production?
    mount Sidekiq::Web => '/sidekiq'

    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
