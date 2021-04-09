Rails.application.routes.draw do
  get 'menubar/_sidebar'
  resources :task_lists
  resources :login
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
