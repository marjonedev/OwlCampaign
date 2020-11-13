Rails.application.routes.draw do

  resources :templates do
    member do
      post :duplicate
      get :preview
    end
  end

  resources :campaigns do
    member do
      post :duplicate
    end
  end
  resources :emaillists do
    member do
      get :add_contact
      put :set_default
      delete :remove_contact
    end
  end
  resources :contacts
  resources :users

  class OnlyAjaxRequest
    def matches?(request)
      request.xhr?
    end
  end

  root 'pages#home'

  get 'pages/home'
  get 'dashboard', to: 'pages#dashboard'
  get 'signup' => 'users#new', :as => "signup"

  get 'login' => 'session#new', :as => "login"
  post 'login' => 'session#create'
  get 'logout' => 'session#destroy', :as => "logout"

  get 'forgot_password', to: 'pages#forgot_password'
end
