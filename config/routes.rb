Rails.application.routes.draw do
  devise_for :users,controllers: {registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: "users/passwords",
    confirmations: "users/confirmations",
    }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'about_us',to: "welcome#about_us"
  get 'backend',to: "backend/base#index"
  get 'backed/worker',to:"backend/base#worker",as: :worker_backend
  get 'backend/pie'=>"backend/base#pie",:as=>:pie
  get "houses/vip"=>"houses#vip_index",:as=>:vip_houses
  resources :users,:only=>[:index] do
    resource :profile,:only=>[:edit,:update]
    resources :salaries,:only=>[:index,:show]
  end
  namespace :admin do
    resources :asset_vips
    resources :users do
      collection do
        post :bulk_update
      end
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
        post :delete_from_read
      end
    end

  end
  resources :houses do
    member do
      get "steps/1"=>"houses#step1",:as=>:step1
      patch "steps/1/update"=>"houses#step1_update",:as=>:update_step1
      get "steps/2"=>"houses#step2",:as=>:step2
      patch "steps/2/update"=>"houses#step2_update",:as=>:update_step2
    end
  end
  namespace :backend do
    resources :resources
    resources :requests
    resources :profiles,:only=>[:index,:edit,:update]
    resources :users,:only=>[:index] do
      resources :salaries
    end
    resources :renters
    # resources :inquiries
    # resources :messages
    # resources :subleases
    # resources :renters
    resources :guests
  end
end
