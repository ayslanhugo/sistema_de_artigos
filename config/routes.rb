Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "public/index"
  get "dashboard/admin"
  resources :articles
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  get "admin_dashboard", to: "dashboard#admin"
  get "meus_artigos", to: "dashboard#student"
  get "gerenciar_artigos", to: "dashboard#manage_articles"
  root "public#index"

  resources :articles do
    # Cria rotas como /articles/1/approve
    member do
      patch :approve
      patch :reject
      patch :set_pending
      get :view_pdf
    end
  end
end
