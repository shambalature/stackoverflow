Rails.application.routes.draw do
  # devise_for :users
  # resources :users
  resources :questions
  get '/search_question' => 'questions#search_question'
  root to: "questions#index"
end
