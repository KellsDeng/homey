Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'about_us',to: "welcome#about_us"


  namespace :admin do
    resources :houses
    resources :user_managers do
      member do
        post :art_designer
        post :housekeeper
        post :employee
        post :cmanager
        post :overseer
        post :salesman
        post :salesman_p
        post :imanager
        post :imanager_p
        post :acc
        post :hr
        post :design_director
        post :design_assistant
        post :rental_user
        post :asset_user
        post :admin
      end
    end

  end
  resources :houses
end
