Baotour::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:show, :index, :new, :edit, :create, :update]
  
  resources :customers
  
  match 'operators/destroy/:id' => 'operators#destroy'
  resources :operators, :only => [:destroy,:create,:update]
  
  match 'accounts/destroy/:id' => 'accounts#destroy'
  resources :accounts, :only => [:destroy,:create,:update]

  resources :refunds, :only => [:index, :destroy, :create, :update]
  
  resources :hotels, :only => [:index,:create,:update,:new,:edit] do
  	 get :search, :on => :collection
  	 post :manage_to_user
  	 post :detroy_manage_hotel
  end
  
  resources :orders, :only => [:create, :destroy, :update] do
  	get :search_guider, :on => :collection
  	get :serach_orgroup, :on => :collection
  	get :uncoverd_orders, :on => :collection #未付款
  	post :add_memo
  end
  
  resources :transfers, :only => [:create,:new,:index,:edit, :show]
  
  resources :fusages, :controller => :fund_usages, :only => [:destroy,:index]
  
  resources :customer_usages, :only => [:index]
  
  resources :invoices, :only => [:index]
  
  resources :invoice_details, :only => [:index,:new,:create,:update,:edit] 
  
  resources :hotel_ledgers, :as => "hledgers"
  
  resources :transactions do
  	get :search, :on => :collection
  	get :get_transactions, :on => :collection
  	post :reduce_cash, :on => :member
  end
  
  #resources :order_groups, :as => "orgroups"
  
  resources :orgroups, :controller => "order_groups" do
  	post :make_done, :on => :member
  end
  
  match '/_save_order_group' => 'OrderGroups#_save_group'
  
  match '/_update_order_group' => 'OrderGroups#_update_group'

  match '/_customer_operator_search' => 'OrderGroups#_customer_operator_search'
  
end
