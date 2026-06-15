Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :admin do
        namespace :auth do
          resources :sessions, only: :create
        end
        resources :inquiries, except: :create
        resources :travel_packages
        resource :user, only: :show
        resources :users, only: [:index, :create, :update, :destroy]
      end
      scope module: :client do
        resources :travel_packages, only: [:index, :show] do
          post 'inquire', on: :member
        end
        resources :inquiries, only: [:create]
      end
    end
  end
end