# app/controllers/public_controller.rb

class PublicController < ApplicationController
  def index
    # 1. Começamos com a base da nossa consulta, já otimizada para evitar o N+1.
    #    Carregamos previamente os utilizadores, imagens de capa e PDFs.
    approved_articles_query = Article.where(status: :aprovado)
                                     .includes(:user)
                                     .with_attached_cover_image
                                     .with_attached_pdf_file

    # 2. Aplicamos o filtro de busca SE o parâmetro 'query' estiver presente.
    if params[:query].present?
      approved_articles_query = approved_articles_query.where("title ILIKE ?", "%#{params[:query]}%")
    end

    # 3. Ordenamos o resultado FINAL da consulta (após aplicar o filtro).
    ordered_query = approved_articles_query.order(created_at: :desc)

    # 4. A Pagy assume o controle APENAS NO FINAL, com a consulta completa e ordenada.
    #    O 'items: 10' define que você quer 10 artigos por página.
    @pagy, @approved_articles = pagy(ordered_query, items: 10)

    # Esta linha para carregar os avisos já estava perfeita.
    @notices = Notice.order(created_at: :desc).limit(5)
  end
end
