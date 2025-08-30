class DashboardController < ApplicationController
  before_action :authenticate_user!
  # CORRIGIDO: Agora o filtro de segurança se aplica a AMBAS as páginas do admin
  before_action :require_admin, only: [ :admin, :manage_articles ]

  def admin
    @pending_articles = Article.where(status: :pendente).order(created_at: :desc)
    @pagy, @pending_articles = pagy(@pending_articles, items: 20)
  end

  def student
    @student_articles = current_user.articles.order(created_at: :desc)
    @pagy, @student_articles = pagy(@student_articles, items: 20)
  end

  def manage_articles
    @articles = Article.includes(:user).order(created_at: :desc)
    if params[:status].present?
      @articles = @articles.where(status: params[:status])
    end
    if params[:query].present?
      search_term = "%#{params[:query]}%"
      @articles = @articles.joins(:user).where("articles.title ILIKE :search OR users.email ILIKE :search", search: search_term)
    end
    @pagy, @articles = pagy(@articles, items: 20)
  end

  private

  def require_admin
    redirect_to root_path, alert: "Acesso não autorizado." unless current_user.admin?
  end
end
