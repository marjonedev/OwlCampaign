Rails.application.routes.draw do
  get 'session/new'
  resources :users
  class OnlyAjaxRequest
    def matches?(request)
      request.xhr?
    end
  end

  root 'pages#home'

  get 'pages/home'
  get 'signup' => 'users#new', :as => "signup"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
