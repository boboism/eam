Eam::Application.routes.draw do
  resources :asset_transfers


  resources :asset_info_adjustments


  resources :asset_cost_adjustments


  resources :assets


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end