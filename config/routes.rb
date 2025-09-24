# config/routes.rb (versão corrigida)

Rails.application.routes.draw do
  get "ajuda", to: "paginas_estaticas#ajuda"
  resources :notices
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  root "public#index"
  get "admin_dashboard", to: "dashboard#admin"
  get "meus_artigos", to: "dashboard#student"
  get "gerenciar_artigos", to: "dashboard#manage_articles"

  namespace :admin do
    resources :users, only: [ :index, :update ]
  end

  get "fale-conosco", to: "paginas_estaticas#fale_conosco"
  post "fale-conosco", to: "paginas_estaticas#enviar_contato"

  resources :articles, except: [ :index ] do
    member do
      patch :approve
      patch :reject
      patch :set_pending
      get :view_pdf
    end
  end
end
