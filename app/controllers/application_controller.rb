# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  # Permite funcionalidades modernas de JS em navegadores seguros
  allow_browser versions: :modern

  # Inclui o módulo da gem Pagy para que a paginação funcione em todos os controllers
  include Pagy::Backend

private

  # Este é o método que acabámos de refinar.
  # Ele é chamado pelo Devise após um login bem-sucedido.
  def after_sign_in_path_for(resource)
    # 'resource' é o utilizador que acabou de fazer login.
    unseen_rejected_articles = resource.articles.where(status: :reprovado, rejection_seen: false)

    if unseen_rejected_articles.any?
      # Usamos .pluck(:title) para uma performance melhor.
      titles = unseen_rejected_articles.pluck(:title).join('", "')
      flash[:alert] = "Atenção: O(s) seguinte(s) artigo(s) foram reprovados e precisam de revisão: \"#{titles}\""

      # update_all é muito eficiente, ótimo uso!
      unseen_rejected_articles.update_all(rejection_seen: true)
    end

    # Continua com o redirecionamento padrão do Devise.
    super
  end

  # Este é o seu outro método, para controle de acesso.
  # Filtro para garantir que apenas administradores possam aceder a uma determinada ação.
  # Uso nos outros controllers: before_action :require_admin, only: [:acao_protegida]
  def require_admin
    # O `&.` garante que não haverá erro se o utilizador não estiver logado.
    redirect_to root_path, alert: "Acesso não autorizado." unless current_user&.admin?
  end
end
