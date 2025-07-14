# frozen_string_literal: true

Rails.application.routes.draw do
  get '/workshops/pending', to: 'workshops#pending'
  get '/tracks/pending', to: 'tracks#pending'
  resources :tracks
  resources :participants, only: %i[create edit update]
  resources :workshop_facilitators
  devise_for :facilitators
  resources :workshops, only: %i[show index edit new edit update destroy]
  resources :feedback_questions, only: %i[create destroy new edit update]
  resources :application_questions, only: %i[create destroy new edit update]

  resources :application_forms, only: %i[create]
  resources :registration_forms, only: %i[create]
  resources :workshop_proposal_forms, only: %i[create new]
  resources :track_proposal_forms, only: %i[create]
  resources :application_status_forms, only: %i[create]

  # get '/dashboard', to: 'dashboard#show'

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
