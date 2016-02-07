Rails.application.routes.draw do
  devise_for :users
    get 'welcome/index'
  resources :topics do
    resources :bookmarks
  end
  root to: 'welcome#index'
  post :incoming, to: 'incoming#create'
end
