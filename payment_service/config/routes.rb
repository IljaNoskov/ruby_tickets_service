# frozen_string_literal: true

Rails.application.routes.draw do
  mount GrapeApi => '/api'
  mount GrapeSwaggerRails::Engine => '/swagger'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
