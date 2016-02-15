Rails.application.routes.draw do
  get 'likes/index'

  devise_for :users
    get 'welcome/index'
  resources :topics do
    resources :bookmarks, except: [:index] do
      resources :likes, only: [:index, :create, :destroy]
    end
  end
  root to: 'welcome#index'
  post '/incoming', to: 'incoming#create'
end
