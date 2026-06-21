Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :admin do
        namespace :auth do
          resources :sessions, only: :create
          resources :registrations, only: :create
        end

        resources :users, only: [:index, :create, :update, :destroy]
      end
    end
  end
end