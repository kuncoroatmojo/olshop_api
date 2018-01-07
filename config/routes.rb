Rails.application.routes.draw do
  get 'shipments/create'

  get 'shipments/show'

  get 'shipments/update'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #scope :api, defaults: {format: :json} do
    resources :users, :only => [:index, :show, :create]
    resources :orders, :only => [:index, :show, :create, :update]
    resources :placements, :only => [:index, :show, :add_product, :create, :destroy]
    resources :placement_coupons, :only => [:index, :create, :destroy]
    resources :payments, :only => [:create]
    resources :shipments, :only => [:show, :create, :update]
    resources :products, :only => [:index, :show, :create]
    resources :coupons, :only => [:index, :show, :create]
  #resources :products, :only => [:create, :update, :destroy]
end
