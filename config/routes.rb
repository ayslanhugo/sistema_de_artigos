Rails.application.routes.draw do
  get "ajuda", to: "paginas_estaticas#ajuda"
  resources :notices
  # 1. Configuração do Devise para usuários
  devise_for :users

  # 2. Rota de Health Check (apenas uma vez)
  # Usada por serviços como o Render para saber se o app está no ar.
  get "up" => "rails/health#show", as: :rails_health_check

  # 3. Rota principal ("/") e Dashboards
  root "public#index" # Define a página inicial
  get "admin_dashboard", to: "dashboard#admin"
  get "meus_artigos", to: "dashboard#student"
  get "gerenciar_artigos", to: "dashboard#manage_articles"

  get "fale-conosco", to: "paginas_estaticas#fale_conosco"
  post "fale-conosco", to: "paginas_estaticas#enviar_contato"
    # 4. Rotas para os Artigos (TUDO EM UM SÓ LUGAR)
    # Isso cria as 7 rotas padrão (index, show, new, edit, create, update, destroy)
    # E adiciona nossas ações personalizadas para cada artigo.
    resources :articles, except: [ :index ] do
    member do
      patch :approve
      patch :reject
      patch :set_pending
      get :view_pdf
    end
  end
end
