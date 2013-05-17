Eam::Application.routes.draw do
  resources :asset_categorizations


  resources :asset_transfers do
    post :submit, :on => :member
  end


  resources :asset_info_adjustments do
    post :submit, :on => :member
  end


  resources :asset_cost_adjustments do
    post :submit, :on => :member
  end


  resources :assets


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end
