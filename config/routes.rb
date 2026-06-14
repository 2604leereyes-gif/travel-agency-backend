Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :admin do
        namespace :auth do
          resources :sessions, only: :create
        end
        resources :travel_packages
        resource :user, only: :show
        resources :users, only: [:index, :create, :update, :destroy]
      end
      scope module: :client do
        resources :travel_packages, only: [:index, :show]
        resources :inquiries, only: [:create]
      end
    end
  end
end