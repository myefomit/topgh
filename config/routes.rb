Rails.application.routes.draw do
  root to: 'contributors#index'
  resources :contributors, only: :create do
    resource :digest, only: :show
  end

  post '/zip', to: 'digests#zip'
end
