Rails.application.routes.draw do

  resources :templates
  resources :campaigns
  resources :contacts
  resources :users

  class OnlyAjaxRequest
    def matches?(request)
      request.xhr?
    end
  end

  root 'pages#home'

  get 'pages/home'
  get 'signup' => 'users#new', :as => "signup"

  get 'login' => 'session#new', :as => "login"
  post 'login' => 'session#create'
  get 'logout' => 'session#destroy', :as => "logout"

  get 'forgot_password', to: 'pages#forgot_password'
end
