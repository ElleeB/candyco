Rails.application.routes.draw do
  resources :warehouses
  resources :products
  resources :reports, only: :index

  resources :orders
  post "order_generate", to: "orders#create"
  post "delete_all", to: "orders#destroy_all"

  namespace :api do
    get '/report_data', to: 'data_api#report_data'
  end
end
