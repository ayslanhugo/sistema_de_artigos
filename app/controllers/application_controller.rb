class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  include Pagy::Backend

private

  def require_admin
    redirect_to root_path, alert: "Acesso não autorizado." unless current_user.admin?
  end
end
