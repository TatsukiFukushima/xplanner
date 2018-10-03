Rails.application.routes.draw do

  root    'landing_page#home'
  get     '/signup',    to: 'users#new'
  get     '/login',     to: 'sessions#new'
  get     '/messages/:id', to: 'users#show'
  post    '/login',     to: 'sessions#create'
  delete  '/logout',    to: 'sessions#destroy'
  resources :users, except: :show, shallow: true do
    member do
      get :following, :followers
    end
    resources :long_term_goals, except: :show, shallow: true do 
      put :sort
      resources :memo, except: [:new, :create, :index]
      get '/memo/new' => 'memo#l_new'
      post '/memo' => 'memo#l_create'
      resources :mid_term_goals, except: :show, shallow: true do 
        put :sort
        get '/memo/new' => 'memo#m_new'
        post '/memo' => 'memo#m_create'
        resources :short_term_goals, except: :show, shallow: true do 
          put :sort 
          get '/memo/new' => 'memo#s_new'
          post '/memo' => 'memo#s_create'
          resources :approaches, except: :show, shallow: true do 
            put :sort 
            get '/memo/new' => 'memo#a_new'
            post '/memo' => 'memo#a_create'
          end 
        end 
      end 
    end 
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
  mount ActionCable.server => '/cable'
end
