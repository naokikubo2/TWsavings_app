Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end

  resources :undone_actions, only: [:new, :create, :destroy, :edit, :update]
  resources :savings_records, only: [:new, :create, :destroy, :index, :show] do
    resources :comments, only: %w[create destroy]
  end

  resources :users, only: %w[index show] do
    post :follow
  end

end
