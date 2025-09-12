class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  include Pagy::Backend

private

  # This special Devise method is called automatically after a successful login.
  def after_sign_in_path_for(resource)
    # 'resource' is the user who just logged in.

    # 1. We look for the user's articles that were rejected and whose notification has not yet been seen.
    unseen_rejected_articles = resource.articles.where(status: :reprovado, rejection_seen: false)

    # 2. If we find any...
    if unseen_rejected_articles.any?
      # ...we create an alert message with the titles of the articles.
      titles = unseen_rejected_articles.map(&:title).join('", "')
      flash[:alert] = "Atenção: O(s) seguinte(s) artigo(s) foram reprovados e precisam de revisão: \"#{titles}\""

      # 3. WE MARK THE ARTICLES AS SEEN so as not to notify again.
      unseen_rejected_articles.update_all(rejection_seen: true)
    end

    # 4. Finally, we continue with the default Devise redirect.
    super
  end

  def require_admin
    redirect_to root_path, alert: "Acesso não autorizado." unless current_user.admin?
  end
end
