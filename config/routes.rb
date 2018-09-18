Rails.application.routes.draw do
  root to: 'contributors#index'
  resource :contributors, only: :create
end
