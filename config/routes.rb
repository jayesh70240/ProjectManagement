Rails.application.routes.draw do
  root 'main#index'

  devise_for :users

  resources :users, only: [:new, :create] do
    resources :tasks, only: [:index, :show, :new]
  end
  
  resources :projects do 
    resources :tasks, only: [:new]
  end
  
  resources :tasks

  get '/tasks/:id/complete', to: "tasks#complete"
  delete '/tasks/:id', to: "tasks#destroy"
end