class PublicController < ApplicationController
  def index
  # Começamos com a base da nossa consulta (sem carregar os dados ainda)
  approved_articles_query = Article.where(status: :aprovado).order(created_at: :desc)

  if params[:query].present?
    approved_articles_query = approved_articles_query.where("title ILIKE ?", "%#{params[:query]}%")
  end

  # A Pagy assume o controle aqui!
  # Ela recebe a consulta e nos devolve:
  # 1. O objeto @pagy (com informações como o total de páginas)
  # 2. A lista de artigos APENAS da página atual
  @pagy, @approved_articles = pagy(approved_articles_query)
  end
end