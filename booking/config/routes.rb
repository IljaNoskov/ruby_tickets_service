Rails.application.routes.draw do
  mount GrapeApi => '/api'
  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
