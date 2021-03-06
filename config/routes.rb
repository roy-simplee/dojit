Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:update, :show, :index]
	# resources :posts
  # resources :topics

  resources :topics do
    resources :posts, except: [:index], controller: 'topics/posts'
  end
  resources :posts, only: [:index] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end
  
  get 'about' => 'welcome#about'
  
  root to: 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
