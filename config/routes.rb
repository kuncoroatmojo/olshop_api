Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #scope :api, defaults: {format: :json} do
    resources :users, :only => [:show] do
      resources :orders, :only => [:index, :show, :create] do
        resources :placements, :only => [:index, :show, :add_product, :create, :destroy]
      end
    end
  #resources :products, :only => [:create, :update, :destroy]
end
