Rails.application.routes.draw do

  resources :templates do
    member do
      post :duplicate
      get :preview
    end
  end

  resources :campaigns do
    member do
      get :campaign_subject
      patch :campaign_subject
      get :choose_template
      patch :choose_template
      get :write_content
      patch :write_content
      get :schedule_email
      patch :schedule_email

      post :duplicate
      patch :update_send
      put :update_send
      get :preview
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

  resources :from_emails

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

  # pages
  get 'features', to: 'pages#features'
  get 'pricing', to: 'pages#pricing'
  get 'security', to: 'pages#security'
  get 'guides', to: 'pages#guides'
  get 'faqs', to: 'pages#faqs'
  get 'about', to: 'pages#about'
  get 'privacy', to: 'pages#privacy'
  get 'terms', to: 'pages#terms'
  get 'contact', to: 'pages#contact'
end
