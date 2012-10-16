Wikileaks::Application.routes.draw do

  resources :leaks, only: [:index, :show]

  root :to => 'leaks#index'

end
