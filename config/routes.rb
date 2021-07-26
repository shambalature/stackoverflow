# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    resources :answers
  end
  get '/search_question' => 'questions#search_question'
  root to: 'questions#index'
end
