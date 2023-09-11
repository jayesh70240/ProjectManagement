Rails.application.routes.draw do
  devise_for :users
  root 'main#index'

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