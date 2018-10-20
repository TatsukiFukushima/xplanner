Rails.application.routes.draw do

  root    'landing_page#home'
  get     '/signup',    to: 'users#new'
  get     '/login',     to: 'sessions#new'
  get     '/messages/:id', to: 'users#show'
  post    '/login',     to: 'sessions#create'
  delete  '/logout',    to: 'sessions#destroy'
  delete  '/l_like/:id',  to: 'likes#l_destroy', as: 'l_like'
  delete  '/m_like/:id',  to: 'likes#m_destroy', as: 'm_like'
  delete  '/s_like/:id',  to: 'likes#s_destroy', as: 's_like'
  delete  '/a_like/:id',  to: 'likes#a_destroy', as: 'a_like'
  get     'likes',        to: 'likes#index'
  get     'xrooms/search', to: 'xrooms#list'
  get     'search/result', to: 'search#result'
  resources :users, except: :show, shallow: true do
    member do
      get :following, :followers, :blocking
    end
    resources :long_term_goals, except: :show, shallow: true do 
      put :sort
      resources :memo, except: [:new, :create, :index] # 後でネストから外す
      get '/memo/new' => 'memo#l_new'
      post '/memo' => 'memo#l_create'
      post '/likes' => 'likes#l_create'
      resources :comments, only: :index
      post '/comments' => 'comments#l_create'
      resources :mid_term_goals, except: :show, shallow: true do 
        put :sort
        get '/memo/new' => 'memo#m_new'
        post '/memo' => 'memo#m_create'
        post '/likes' => 'likes#m_create'
        resources :comments, only: :index
        post '/comments' => 'comments#m_create'
        resources :short_term_goals, except: :show, shallow: true do 
          put :sort 
          get '/memo/new' => 'memo#s_new'
          post '/memo' => 'memo#s_create'
          post '/likes' => 'likes#s_create'
          resources :comments, only: :index
          post '/comments' => 'comments#s_create'
          resources :approaches, except: :show, shallow: true do 
            put :sort 
            get '/memo/new' => 'memo#a_new'
            post '/memo' => 'memo#a_create'
            post '/likes' => 'likes#a_create'
            resources :comments, only: :index
            post '/comments' => 'comments#a_create'
          end 
        end 
      end 
    end 
  end
  resources :comments, only: :destroy, shallow: true do 
    resources :comment_replies, only: [:index, :destroy, :create]
  end
  resources :xrooms
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
  resources :block_relationships, only: [:create, :destroy]
  mount ActionCable.server => '/cable'
end
