# app/controllers/public_controller.rb
class PublicController < ApplicationController
  def index
    approved_articles_query = Article.where(status: :aprovado)
                                     .includes(:user)
                                     .with_attached_pdf_file

    if params[:query].present?
      approved_articles_query = approved_articles_query.where("title ILIKE ?", "%#{params[:query]}%")
    end

    ordered_query = approved_articles_query.order(created_at: :desc)

    @pagy, @approved_articles = pagy(ordered_query, items: 10)

    @notices = Notice.order(created_at: :desc).limit(5)
  end
end
