Eam::Application.routes.draw do
  resources :accessory_adjustments do
    put :submit,  :on => :member
    put :confirm, :on => :member
    put :approve, :on => :member
    get :approvable, :action => "index_approvable", :on => :collection
    get :confirmable, :action => "index_confirmable", :on => :collection
  end


  resources :asset_categorizations do
    put :submit,  :on => :member
    put :confirm, :on => :member
    put :approve, :on => :member
    get :approvable, :action => "index_approvable", :on => :collection
    get :confirmable, :action => "index_confirmable", :on => :collection
  end


  resources :asset_transfers do
    put :submit, :on => :member
    put :confirm, :on => :member
    put :approve, :on => :member
    get :approvable, :action => "index_approvable", :on => :collection
    get :confirmable, :action => "index_confirmable", :on => :collection
  end


  resources :asset_info_adjustments do
    post :submit, :on => :member
  end


  resources :asset_cost_adjustments do
    post :submit, :on => :member
  end


  resources :assets, :except => [:edit, :update]


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end
