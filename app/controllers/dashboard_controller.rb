class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, only: [ :admin, :manage_articles ]

  def admin
    pending_articles_query = Article.where(status: :pendente)
                                    .includes(:user)
                                    .order(created_at: :desc)

    @pagy, @pending_articles = pagy(pending_articles_query, items: 20)
  end

  def student
    student_articles_query = current_user.articles
                                         .with_attached_cover_image
                                         .with_attached_pdf_file
                                         .order(created_at: :desc)

    @pagy, @student_articles = pagy(student_articles_query, items: 20)
  end

  def manage_articles
    articles_query = Article.includes(:user)
                            .with_attached_cover_image
                            .order(created_at: :desc)

    if params[:status].present?
      articles_query = articles_query.where(status: params[:status])
    end

    if params[:query].present?
      search_term = "%#{params[:query]}%"
      articles_query = articles_query.joins(:user).where("articles.title ILIKE :search OR users.email ILIKE :search", search: search_term)
    end

    @pagy, @articles = pagy(articles_query, items: 20)
  end
end
