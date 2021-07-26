Rails.application.routes.draw do
  # devise_for :users
  # resources :users
  resources :questions do
  	get "answers", on: :member
  end
  get '/search_question' => 'questions#search_question'
  root to: "questions#index"
end
