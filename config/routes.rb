Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:update]
	# resources :posts
 #  resources :topics

  resources :topics do
    resources :posts, except: [:index]
  end
  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
  end
  
	get 'about' => 'welcome#about'
	
  root to: 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
