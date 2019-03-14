Rails.application.routes.draw do
  root to: 'miscs#top'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  
  resources :tasks
  
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :selected
    end
  end
  
  resources :task_permissions, only: [:create, :destroy]
end
