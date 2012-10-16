Wikileaks::Application.routes.draw do

  resources :cables, only: [:index, :show]

  root :to => 'cables#index'

end
