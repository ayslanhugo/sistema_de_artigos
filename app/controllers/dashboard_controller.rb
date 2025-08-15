class DashboardController < ApplicationController
  # Garante que apenas usuários logados acessem
  before_action :authenticate_user!
  # Garante que apenas admins acessem
  before_action :require_admin, only: [:admin]

  def admin
    @pending_articles = Article.where(status: :pendente)
  end

  def manage_articles
    @articles = Article.all.order(created_at: :desc) # Começa buscando todos

    # Lógica para filtrar por status, se um filtro for selecionado
    if params[:status].present?
      @articles = @articles.where(status: params[:status])
    end
  end

  def student
    # Busca apenas os artigos que pertencem ao usuário logado
    # e ordena pelos mais recentes primeiro.
    @student_articles = current_user.articles.order(created_at: :desc)
  end
  private

  def require_admin
    # Redireciona para a página inicial se o usuário não for admin
    redirect_to root_path, alert: "Acesso não autorizado." unless current_user.admin?
  end
end