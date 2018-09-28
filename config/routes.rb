Rails.application.routes.draw do
  
  root    'landing_page#home'
  get     '/signup',    to: 'users#new'
  get     '/login',     to: 'sessions#new'
  post    '/login',     to: 'sessions#create'
  delete  '/logout',    to: 'sessions#destroy'
  resources :users, except: :show, shallow: true do
    member do
      get :following, :followers
    end
    resources :long_term_goals, except: :show, shallow: true do 
      put :sort
      resources :mid_term_goals, shallow: true do 
        put :sort
      end 
    end 
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
end
