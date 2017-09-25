Rails.application.routes.draw do

  resources :pokemon, only:[:index, :show]

  # get 'pokemon/index'
  #
  # get 'pokemon/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
