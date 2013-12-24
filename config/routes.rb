Photobooth::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'pages#home'

  #get 'pages#about', as: :about
  resources :events do
    resources :photos, shallow: true
    put :activate, on: :member
  end

end
