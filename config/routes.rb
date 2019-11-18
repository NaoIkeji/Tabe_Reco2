Rails.application.routes.draw do

get '/' => 'home#top', as: 'root'

namespace :user do
    get '/users/:id/my_page' => 'users#my_page', as: 'my_page'
    get '/users/:id/my_data' => 'users#my_data', as: 'my_data'
    get '/users/:id/setting_changing' => 'users#setting_changing', as: 'setting_changing'
    get '/users/:id/daily_meal' => 'users#daily_meal', as: 'daily_meal'
    get '/users/:id/daily_meal_balance' => 'users#daily_meal_balance', as: 'daily_meal_balance'
    get '/users/json' => 'users#json', as: 'user_json'

    get '/meals/meal_indication' =>'meals#meal_indication', as: 'meal_indication'

    # フォローする
    post '/follow/:id' => 'relationships#follow', as: 'follow'
    # フォロー外す
    post '/unfollow/:id' => 'relationships#unfollow', as: 'unfollow'

    get '/posts/:id/my_page' =>'posts#my_page', as: 'posts_my_page'
    # get '/posts/:id/post_comments' => 'posts#post_comments', as: 'post_comments'
    get '/contacts/contact_completed' => 'contacts#contact_complete', as: 'contact_complete'

    resources :meals
    resources :foods, only: [:create, :update, :edit, :destroy]
    resources :food_points, only: [:show, :new, :create, :update, :edit, :destroy]
    resources :targets, only: [:create, :edit, :update, :destroy]
    resources :contacts, only: [:new, :create]
    # resources :users

    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resource :cheers, only: [:create, :destroy]
      resources :comments, only: [:show, :create, :edit, :update, :destroy]
    end

    resources :users do
        resource :relationships, only: [:create, :destroy]
        member do
            get :following, :followers
        end
     end
end



  namespace :admin do
    get 'home/top' => 'home#top'
    get '/user/:id/edit_list' => 'user#edit_list', as: 'user_edit_list'
    get '/user/:id/post_list' => 'user#post_list', as: 'user_post_list'

  	resources :foods, only: [:index, :new, :create, :update, :edit, :destroy]
    resources :users
    resources :posts
  end

    devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
    }

    devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
    }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end