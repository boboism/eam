Eam::Application.routes.draw do
  get "asset_number_poolings/index"

  get "asset_number_poolings/show"

  resources :accessory_adjustments do
    put :submit,  :on => :member
    put :confirm, :on => :member
    put :approve, :on => :member
    get :approvable, :action => "index_approvable", :on => :collection
    get :confirmable, :action => "index_confirmable", :on => :collection
  end


  resources :asset_categorizations do
    put :submit,  :on => :member
    put :arrange_number, :on => :member
    put :confirm, :on => :member
    put :approve, :on => :member
    put :reject,  :on => :member
    get :upload, :on => :collection
    post :import,  :on => :collection
    get :approvable, :action => "index_approvable", :on => :collection
    get :confirmable, :action => "index_confirmable", :on => :collection
    get :number_arrangeable, :action => "index_number_arrangeable", :on => :collection
  end


  resources :asset_transfers do
    put :submit,  :on => :member
    put :confirm, :on => :member
    put :approve, :on => :member
    put :reject,  :on => :member
    get :approvable, :action => "index_approvable", :on => :collection
    get :confirmable, :action => "index_confirmable", :on => :collection
  end


  resources :asset_info_adjustments do
    put :submit,  :on => :member
    put :confirm, :on => :member
    put :approve, :on => :member
    put :reject,  :on => :member
    get :approvable, :action => "index_approvable", :on => :collection
    get :confirmable, :action => "index_confirmable", :on => :collection
  end


  resources :asset_cost_adjustments do
    put :submit, :on => :member
    put :confirm, :on => :member
    put :approve, :on => :member
    get :approvable, :action => "index_approvable", :on => :collection
    get :confirmable, :action => "index_confirmable", :on => :collection
  end


  resources :assets, :except => [:edit, :update] do 
    put :no_accessory, :on => :member
  end

  resources :master_datas, except: [:destroy] do
    put :enable, :action => "enable", :on => :member
    put :disable, :action => "disable", :on => :member
  end


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end
