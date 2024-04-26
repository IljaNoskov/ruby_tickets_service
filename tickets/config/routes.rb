Rails.application.routes.draw do
  # resources :events
  # resources :tickets
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount GrapeApi => '/api'

end
